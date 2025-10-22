import { useState, useEffect } from "react";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from "@/components/ui/select";
import {
  Dialog,
  DialogContent,
  DialogDescription,
  DialogHeader,
  DialogTitle,
  DialogTrigger,
} from "@/components/ui/dialog";
import { useAuth } from "@/hooks/useAuth";
import { useToast } from "@/hooks/use-toast";
import { useMutation, useQueryClient } from "@tanstack/react-query";
import { apiRequest } from "@/lib/api";
import { User, Settings } from "lucide-react";
import type { User as UserType } from "@shared/schema";

interface ProfileSettingsModalProps {
  trigger?: React.ReactNode;
  open?: boolean;
  onOpenChange?: (open: boolean) => void;
}

// Lista de países con códigos telefónicos
const countries = [
  { code: "+595", name: "Paraguay", flag: "🇵🇾" },
  { code: "+54", name: "Argentina", flag: "🇦🇷" },
  { code: "+55", name: "Brasil", flag: "🇧🇷" },
  { code: "+56", name: "Chile", flag: "🇨🇱" },
  { code: "+57", name: "Colombia", flag: "🇨🇴" },
  { code: "+51", name: "Perú", flag: "🇵🇪" },
  { code: "+598", name: "Uruguay", flag: "🇺🇾" },
  { code: "+58", name: "Venezuela", flag: "🇻🇪" },
  { code: "+591", name: "Bolivia", flag: "🇧🇴" },
  { code: "+593", name: "Ecuador", flag: "🇪🇨" },
  { code: "+1", name: "Estados Unidos", flag: "🇺🇸" },
  { code: "+52", name: "México", flag: "🇲🇽" },
  { code: "+34", name: "España", flag: "🇪🇸" },
];

export default function ProfileSettingsModal({
  trigger,
  open,
  onOpenChange
}: ProfileSettingsModalProps) {
  const { user } = useAuth();
  const { toast } = useToast();
  const queryClient = useQueryClient();
  const [isOpen, setIsOpen] = useState(false);

  // Extraer código de país del número existente
  const getCountryCodeFromNumber = (number: string) => {
    if (!number) return "+595"; // Paraguay por defecto
    const country = countries.find(c => number.startsWith(c.code));
    return country ? country.code : "+595";
  };

  // Extraer número sin código de país
  const getNumberWithoutCountryCode = (number: string) => {
    if (!number) return "";
    const countryCode = getCountryCodeFromNumber(number);
    return number.replace(countryCode, "");
  };

  const [formData, setFormData] = useState({
    fullName: user?.fullName || "",
    email: user?.email || "",
    countryCode: getCountryCodeFromNumber(user?.whatsappNumber || ""),
    phoneNumber: getNumberWithoutCountryCode(user?.whatsappNumber || ""),
    currentPassword: "",
    newPassword: "",
    confirmPassword: "",
  });

  // Sincronizar formData con los datos del usuario cuando cambien o cuando se abre el modal
  useEffect(() => {
    if (user && (open || isOpen)) {
      const whatsappNumber = user.whatsappNumber || "";
      setFormData({
        fullName: user.fullName || "",
        email: user.email || "",
        countryCode: getCountryCodeFromNumber(whatsappNumber),
        phoneNumber: getNumberWithoutCountryCode(whatsappNumber),
        currentPassword: "",
        newPassword: "",
        confirmPassword: "",
      });
    }
  }, [user, open, isOpen]);

  const updateProfileMutation = useMutation({
    mutationFn: async (updates: Partial<UserType>) => {
      const response = await apiRequest("PUT", `/api/users/${user?.id}`, updates);
      if (!response.ok) {
        const error = await response.json();
        throw new Error(error.message || "Error al actualizar perfil");
      }
      return await response.json();
    },
    onSuccess: (updatedUser) => {
      // Actualizar los datos del usuario en el cache
      queryClient.setQueryData(["/api/auth/me"], updatedUser);
      queryClient.invalidateQueries({ queryKey: ["/api/auth/me"] });

      toast({
        title: "Perfil actualizado",
        description: "Tu información personal ha sido actualizada exitosamente.",
      });

      // Cerrar modal
      if (onOpenChange) {
        onOpenChange(false);
      } else {
        setIsOpen(false);
      }
    },
    onError: (error: any) => {
      toast({
        title: "Error al actualizar",
        description: error.message || "No se pudo actualizar tu perfil",
        variant: "destructive",
      });
    },
  });

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault();

    // Validaciones básicas
    if (!formData.fullName.trim()) {
      toast({
        title: "Campo requerido",
        description: "El nombre completo es obligatorio",
        variant: "destructive",
      });
      return;
    }

    if (!formData.email.trim()) {
      toast({
        title: "Campo requerido",
        description: "El email es obligatorio",
        variant: "destructive",
      });
      return;
    }

    // Validar formato de email
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    if (!emailRegex.test(formData.email)) {
      toast({
        title: "Email inválido",
        description: "Por favor ingresa un email válido",
        variant: "destructive",
      });
      return;
    }

    // Validar WhatsApp si se proporciona
    if (formData.phoneNumber && !/^\d{8,15}$/.test(formData.phoneNumber)) {
      toast({
        title: "Número de WhatsApp inválido",
        description: "El número debe contener solo dígitos (8-15 caracteres)",
        variant: "destructive",
      });
      return;
    }

    // Validar contraseña si se está intentando cambiar
    if (formData.newPassword || formData.confirmPassword || formData.currentPassword) {
      if (!formData.currentPassword) {
        toast({
          title: "Contraseña actual requerida",
          description: "Debes ingresar tu contraseña actual para cambiarla",
          variant: "destructive",
        });
        return;
      }

      if (!formData.newPassword) {
        toast({
          title: "Nueva contraseña requerida",
          description: "Debes ingresar una nueva contraseña",
          variant: "destructive",
        });
        return;
      }

      if (formData.newPassword.length < 6) {
        toast({
          title: "Contraseña muy corta",
          description: "La contraseña debe tener al menos 6 caracteres",
          variant: "destructive",
        });
        return;
      }

      if (formData.newPassword !== formData.confirmPassword) {
        toast({
          title: "Las contraseñas no coinciden",
          description: "La nueva contraseña y la confirmación deben ser iguales",
          variant: "destructive",
        });
        return;
      }
    }

    // Preparar datos para enviar
    const whatsappNumber = formData.phoneNumber ?
      `${formData.countryCode}${formData.phoneNumber}` : null;

    const updates: Partial<UserType> & { currentPassword?: string; newPassword?: string } = {
      fullName: formData.fullName.trim(),
      email: formData.email.trim(),
      whatsappNumber,
    };

    // Agregar contraseñas si se están cambiando
    if (formData.newPassword && formData.currentPassword) {
      updates.currentPassword = formData.currentPassword;
      updates.newPassword = formData.newPassword;
    }

    updateProfileMutation.mutate(updates);
  };

  const handleInputChange = (field: keyof typeof formData, value: string) => {
    setFormData(prev => ({
      ...prev,
      [field]: value
    }));
  };

  const handleOpenChange = (open: boolean) => {
    if (onOpenChange) {
      onOpenChange(open);
    } else {
      setIsOpen(open);
    }

    // Resetear formulario cuando se cierra
    if (!open && user) {
      setFormData({
        fullName: user.fullName || "",
        email: user.email || "",
        countryCode: getCountryCodeFromNumber(user.whatsappNumber || ""),
        phoneNumber: getNumberWithoutCountryCode(user.whatsappNumber || ""),
        currentPassword: "",
        newPassword: "",
        confirmPassword: "",
      });
    }
  };

  if (!user) return null;

  const isControlled = typeof open !== "undefined";

  return (
    <Dialog
      open={isControlled ? open : isOpen}
      onOpenChange={handleOpenChange}
    >
      {trigger && (
        <DialogTrigger asChild>
          {trigger}
        </DialogTrigger>
      )}

      <DialogContent className="sm:max-w-[500px] max-h-[90vh] overflow-y-auto">
        <DialogHeader>
          <DialogTitle className="flex items-center gap-2">
            <User className="h-5 w-5" />
            Configuración de Perfil
          </DialogTitle>
          <DialogDescription>
            Actualiza tu información personal. Los cambios se guardarán inmediatamente.
          </DialogDescription>
        </DialogHeader>

        <form onSubmit={handleSubmit} className="space-y-4">
          <div className="space-y-2">
            <Label htmlFor="fullName">Nombre Completo *</Label>
            <Input
              id="fullName"
              type="text"
              value={formData.fullName}
              onChange={(e) => handleInputChange("fullName", e.target.value)}
              placeholder="Tu nombre completo"
              required
            />
          </div>

          <div className="space-y-2">
            <Label htmlFor="email">Email *</Label>
            <Input
              id="email"
              type="email"
              value={formData.email}
              onChange={(e) => handleInputChange("email", e.target.value)}
              placeholder="tu@email.com"
              required
            />
          </div>

          <div className="space-y-2">
            <Label>WhatsApp (opcional)</Label>
            <div className="flex gap-2">
              <Select
                value={formData.countryCode}
                onValueChange={(value) => handleInputChange("countryCode", value)}
              >
                <SelectTrigger className="w-[140px]">
                  <SelectValue placeholder="País" />
                </SelectTrigger>
                <SelectContent>
                  {countries.map((country) => (
                    <SelectItem key={country.code} value={country.code}>
                      <div className="flex items-center gap-2">
                        <span>{country.flag}</span>
                        <span>{country.code}</span>
                      </div>
                    </SelectItem>
                  ))}
                </SelectContent>
              </Select>

              <Input
                type="tel"
                value={formData.phoneNumber}
                onChange={(e) => {
                  // Solo permitir números
                  const value = e.target.value.replace(/\D/g, '');
                  handleInputChange("phoneNumber", value);
                }}
                placeholder="981234567"
                className="flex-1"
              />
            </div>
            <p className="text-xs text-muted-foreground">
              Selecciona tu país y el código se agregará automáticamente
            </p>
            {formData.phoneNumber && (
              <p className="text-xs text-green-600">
                Número completo: {formData.countryCode}{formData.phoneNumber}
              </p>
            )}
          </div>

          <div className="border-t pt-4 mt-4">
            <h3 className="text-sm font-semibold mb-3">Cambiar Contraseña (opcional)</h3>

            <div className="space-y-3">
              <div className="space-y-2">
                <Label htmlFor="currentPassword">Contraseña Actual</Label>
                <Input
                  id="currentPassword"
                  type="password"
                  value={formData.currentPassword}
                  onChange={(e) => handleInputChange("currentPassword", e.target.value)}
                  placeholder="Tu contraseña actual"
                  autoComplete="current-password"
                />
              </div>

              <div className="space-y-2">
                <Label htmlFor="newPassword">Nueva Contraseña</Label>
                <Input
                  id="newPassword"
                  type="password"
                  value={formData.newPassword}
                  onChange={(e) => handleInputChange("newPassword", e.target.value)}
                  placeholder="Mínimo 6 caracteres"
                  autoComplete="new-password"
                />
              </div>

              <div className="space-y-2">
                <Label htmlFor="confirmPassword">Confirmar Nueva Contraseña</Label>
                <Input
                  id="confirmPassword"
                  type="password"
                  value={formData.confirmPassword}
                  onChange={(e) => handleInputChange("confirmPassword", e.target.value)}
                  placeholder="Repite la nueva contraseña"
                  autoComplete="new-password"
                />
              </div>

              {formData.newPassword && formData.confirmPassword && formData.newPassword !== formData.confirmPassword && (
                <p className="text-xs text-destructive">
                  Las contraseñas no coinciden
                </p>
              )}
            </div>
          </div>

          <div className="flex justify-end gap-3 pt-4">
            <Button
              type="button"
              variant="outline"
              onClick={() => handleOpenChange(false)}
              disabled={updateProfileMutation.isPending}
            >
              Cancelar
            </Button>
            <Button
              type="submit"
              disabled={updateProfileMutation.isPending}
            >
              {updateProfileMutation.isPending ? "Guardando..." : "Guardar Cambios"}
            </Button>
          </div>
        </form>
      </DialogContent>
    </Dialog>
  );
}