# Script instalar [Odoo](https://www.odoo.com "Odoo's Homepage") 11 para ubuntu 16.04 & 18.04
###### con las dependencias y modulos nesesarios para facturacion electronica CHILE.
```
los modulos que se instalan son los siguientes:
* l10n_cl_chart_of_account de  [Konos](https://github.com/KonosCL)
* l10n_cl_dte_point_of_sale [Daniel Santibáñez Polanco](https://gitlab.com/dansanti)
* l10n_cl_fe [Daniel Santibáñez Polanco](https://gitlab.com/dansanti)
* payment_khipu [Daniel Santibáñez Polanco](https://gitlab.com/dansanti)
* payment_webpay [Daniel Santibáñez Polanco](https://gitlab.com/dansanti)
* reporting-engine
* Scrip intalacion [Odoo](https://www.odoo.com "Odoo's Homepage") https://github.com/Yenthe666/InstallScript

Es super basico el scrip basicamente ejectuta otro script de [Yenthe666](https://github.com/Yenthe666/InstallScript) para instalacion odoo, clona los repositorios de los modulos mencionado e instala las dependecias para correecto funcionamiento de odoo y los modulos de facturacion electronica CHILENA

## Instalacion:
#### 1. bajar el script:
```
sudo wget https://raw.githubusercontent.com/tdcomcl/Instalar_Odoo11_dte/master/installscrip.sh
```
#### 3. hacer ejecutable el script
```
sudo chmod +x odoo_install.sh
```
#### 4. Executar el script:
```
sudo ./odoo_install.sh
```

## Recuerden canmbiar Password en /etc/odoo-server.conf
