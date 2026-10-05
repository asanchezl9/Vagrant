# **Tarea 1.1.2 - Vagrant**
##### _Amparo Sánchez Ledo - 02/10/2026_

> Antes de comenzar, debemos saber que (según la documentación oficial) **Vagrant** es una herramienta para _construir y gestionar entornos de máquinas virtuales en un único flujo de trabajo_.

![Vagrant logo](https://enjoybahia.es/wp-content/uploads/2020/02/vagrant-logo.png)

## **_Punto A. Investiga antes de modificar el entorno_**

#### **_1. Vagrant y el Vagrantfile_**

- **_¿Qué problema resuelve Vagrant?_**
    - En una situación real de trabajo, el configurar servidores a mano puede provocar _errores u olvidos_ si otra persona intenta replicarlo en otro PC, pero gracias a Vagrant (que permite describir el entorno en archivos de texto que se guardan en Git) aseguras que todos tengan exactamente la _misma máquina y configuraciones_, de manera que permite _borrar y recrearla de cero en cuestión de minutos_.
  
- **_Distinción de elementos_**
    - **Anfitrión:** _Ordenador físico_ donde instalas todo
    - **Proveedor de virtualización:** _Programa que crea y ejecuta las máquinas virtuales_, de manera que Vagrant únicamente le da órdenes.
    - **Box:** _Plantilla o imagen base preinstalada del sistema operativo_ (en este caso, Debian 12) que Vagrant descarga y clona para no tener que instalar de cero con una ISO.
    - **Máquina virtual:** _Servidor virtual_ que ya está corriendo dentro del proveedor a partir de esa box.

- **_Lenguaje de Vagrantfile_**
    - El lenguaje en el que está escrito el Vagrantfile es _Ruby_, pero solo con asignaciones básicas de manera que no es necesario saber programar en él.


#### **_Punto 2. Aprovisionamiento_**

- **_¿Qué es un provisioner?_**
    - Herramienta de Vagrant que _automatiza la instalación de programas y la configuración del sistema_ para no hacerlo a mano al encender la máquina.

- **_¿Dónde se ejecuta el script?_**
    - Se ejecuta _dentro de la máquina virtual_ (usando _root_).

- **_¿Cuándo lanza Vagrant el script?_**
    - _Por defecto_, lo lanza solo la primera vez que ejecutas _vagrant up_ al crear la máquina.

- **_Diferencia entre inline: y path:_**
    - **inline:** Escribes los comandos directamente metidos dentro del propio _Vagrantfile_.
    - **path:** Le indicas la _ruta_ a un archivo de script externo guardado en tu carpeta.

- **_¿Qué ocurre si modificas el script después del primer vagrant up y cómo lo ejecutas de nuevo?_**
    - Si lo editas después, no se ejecuta solo al arrancar la máquina. Para forzar que se ejecute de nuevo, tienes que lanzar el comando _vagrant provision_ (con la máquina encendida) o _vagrant reload --provision_ (si quieres reiniciarla).


#### **_Punto 3. Interfaces y redes_**

- **_¿Qué conexión de red configura Vagrant por defecto y para qué la utiliza?_**
    - Configura siempre la primera tarjeta en modo _NAT_. La usa obligatoriamente para conectarse por SSH a la máquina virtual y para darle salida a Internet.

- **_¿Cómo se añade en el Vagrantfile una segunda interfaz con dirección IP fija?_**
    - Añadiendo la línea _config.vm.network "private_network", ip: "192.168.56.10"._

- **_Comparativa de redes (con quién se comunica la máquina en cada caso)_**
    - **NAT:** Se comunica hacia _Internet_, pero nadie desde fuera puede iniciar conexión hacia la máquina.
    - **Red interna:** Solo _máquinas virtuales entre sí dentro de una red aislada_. No tienen Internet y el _ordenador anfitrión_ no puede comunicarse con ellas.
    - **Red privada host-only:** Se comunican las _máquinas virtuales entre sí_ y también con el _ordenador anfitrión_ (tiene tarjeta virtual en esa red), pero sin salida a Internet.
    - **Red pública:** La máquina se conecta directamente al router real como un ordenador físico más, comunicándose con toda la red local.

- **_¿Qué función cumple el reenvío de puertos?_**
    - _Conecta un puerto del PC anfitrión con uno de la máquina virtual_ para poder acceder a servicios internos a través de la red NAT.

- **_¿Añadir la segunda interfaz elimina la NAT predeterminada?_**
    - No, Vagrant mantiene siempre la NAT en la primera interfaz y crea la nueva red como un segundo adaptador extra.

- **_¿El reenvío de puertos crea una interfaz nueva?_**
    - No, aplica una regla de redirección sobre la primera interfaz NAT que ya existe.


#### **_Punto 4. Órdenes y carpeta compartida_**
| **Orden** | **Uso** | **Ejecución** |
| --- | --- | --- |
| _up_ | crear la máquina por primera vez o encenderla si estaba apagada | Si |
| _status_ | comprobar si la máquina está encendida, apagada o sin crear | Si |
| _ssh_ | administrar o comprobar el sistema desde la terminal de Debian | Si |
| _reload_ | reiniciar la máquina para aplicar cambios realizados | Si |
| _provision_ | ejecutar el script bash sin tener que apagar ni reiniciar la máquina | Si |
| _halt_ | apagar la máquina sin borrarla | Si |
| _destroy_ | eliminar la máquina por completo del disco para empezar de cero | No |

- **_Qué es /vagrant?_**
    - Carpeta dentro de la máquina Debian que está sincronizada en tiempo real con la carpeta proyecto del PC anfitrión (donde se encuentra el Vagrantfile), permitiendo compartir archivos entre ambos automáticamente.


























## **_Fuentes consultadas_**
- [Documentación oficial de Vagrant: Introducción](https://developer.hashicorp.com/vagrant/intro)
- [Documentación oficial de Vagrant: Vagrantfile](https://developer.hashicorp.com/vagrant/docs/vagrantfile)
- [Documentación oficial de Vagrant: Redes](https://developer.hashicorp.com/vagrant/docs/networking)
- [Documentación oficial de Vagrant: Red privada](https://developer.hashicorp.com/vagrant/docs/networking/private_network)
- [Documentación oficial de Vagrant: Redes en VirtualBox](https://developer.hashicorp.com/vagrant/docs/providers/virtualbox/networking)
- [Documentación oficial de Vagrant: Puertos reenviados](https://developer.hashicorp.com/vagrant/docs/networking/forwarded_ports)
- [Documentación oficial de Vagrant: Aprovisionamiento con Bash (Shell)](https://developer.hashicorp.com/vagrant/docs/provisioning/shell)
- Apuntes y material del curso en Moodle.