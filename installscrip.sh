# !/bin/bash
echo -e "ACTUALIZANDO UBUNTU" 
sudo apt update && sudo apt upgrade -y
clear
echo -e "INSTALANDO DEPENDECIAS NESESARIAS ODOO Y FACTURACCION ELECTRONICA"
sleep 3s
sudo apt-get install libssl-dev libxml2-dev libxmlsec1-dev build-essential libssl-dev libffi-dev python3-dev python-suds swig python-dev python-cffi libxml2-dev libxslt1-dev libssl-dev python-lxml python-cryptography python-openssl python-certifi python-defusedxml python3-pip wget -y
sudo apt-get install python3-pip -y
sudo pip3 install lxml pytz cchardet urllib3 xmltodict xlsxwriter requests pysftp pdf417gen xlrd num2words suds-py3 
sudo pip3 installcffi certifi defusedxml cryptography signxml pyOpenSSL phonenumbers xmlsec wsse dicttoxml
sleep 6s
clear
echo -e "descargando e installdo scrip odoo 11"
wget https://raw.githubusercontent.com/Yenthe666/InstallScript/11.0/odoo_install.sh
sudo chmod +x odoo_install.sh
sudo ./odoo_install.sh
echo "Odoo 11 Instalado"
sleep 3s
clear
echo "INICIO GIT CLONE repos DTE"
cd /odoo/custom/addons
echo -e "Clonando mudulos en /odoo/custom/addons"
sleep 3s
sudo git clone https://gitlab.com/dansanti/l10n_cl_dte_point_of_sale.git
sudo git clone https://gitlab.com/dansanti/l10n_cl_fe.git
sudo git clone https://gitlab.com/dansanti/payment_khipu.git
sudo git clone https://gitlab.com/dansanti/payment_webpay.git
#sudo git clone https://gitlab.com/dansanti/l10n_cl_stock_picking.git
sudo git clone https://github.com/OCA/reporting-engine.git 
sudo git clone https://github.com/KonosCL/addons-konos.git
sudo mv addons-konos/l10n_cl_chart_of_account/ /odoo/custom/addons/
sudo rm -rf addons-konos/
echo "AGREGANDO PERMISOS CARPETA ADDONS"
sleep 3s
chown -R odoo: /odoo/custom/addons/* 
chmod +x /odoo/custom/addons/*

##fixed parameters
#odoo
OE_USER="odoo"
OE_HOME="/$OE_USER"
OE_HOME_EXT="/$OE_USER/${OE_USER}-server"
#The default port where this Odoo instance will run under (provided you use the command -c in the terminal)
#Set to true if you want to install it, false if you don't need it or have it already installed.
INSTALL_WKHTMLTOPDF="True"
#Set the default Odoo port (you still have to use -c /etc/odoo-server.conf for example to use this.)
OE_PORT="8069"
#Choose the Odoo version which you want to install. For example: 11.0, 10.0, 9.0 or saas-18. When using 'master' the master version will be installed.
#IMPORTANT! This script contains extra libraries that are specifically needed for Odoo 11.0
OE_VERSION="11.0"
# Set this to True if you want to install Odoo 11 Enterprise!
IS_ENTERPRISE="False"
#set the superadmin password
OE_SUPERADMIN="admin"
OE_CONFIG="${OE_USER}-server"
rm -f /etc/odoo-server.conf
echo -e "* Create server config file"
sudo touch /etc/${OE_CONFIG}.conf
echo -e "* Creating server config file"
sudo su root -c "printf '[options] \n; This is the password that allows database operations:\n' >> /etc/${OE_CONFIG}.conf"
sudo su root -c "printf 'admin_passwd = ${OE_SUPERADMIN}\n' >> /etc/${OE_CONFIG}.conf"
sudo su root -c "printf 'xmlrpc_port = ${OE_PORT}\n' >> /etc/${OE_CONFIG}.conf"
sudo su root -c "printf 'logfile = /var/log/${OE_USER}/${OE_CONFIG}.log\n' >> /etc/${OE_CONFIG}.conf"
if [ $IS_ENTERPRISE = "True" ]; then
    sudo su root -c "printf 'addons_path=${OE_HOME}/enterprise/addons,${OE_HOME_EXT}/addons\n' >> /etc/${OE_CONFIG}.conf"
else
    sudo su root -c "printf 'addons_path=${OE_HOME_EXT}/addons,${OE_HOME}/custom/addons,${OE_HOME}/custom/addons/reporting-engine\n' >> /etc/${OE_CONFIG}.conf"
fi
sudo chown $OE_USER:$OE_USER /etc/${OE_CONFIG}.conf
sudo chmod 640 /etc/${OE_CONFIG}.conf
echo -e "REINICIANDO SERVICIO ODOO"
sleep 3s
sudo /etc/init.d/odoo-server restart
clear
ls -l
echo
echo
echo -e "* Starting Odoo Service"
sudo su root -c "/etc/init.d/$OE_CONFIG stop"
sleep 5s
sudo su root -c "/etc/init.d/$OE_CONFIG start"
echo "-----------------------------------------------------------"
echo "Done! The Odoo server is up and running. Specifications:"
echo "Port: $OE_PORT"
echo "User service: $OE_USER"
echo "User PostgreSQL: $OE_USER"
echo "Code location: $OE_USER"
echo "Addons folder: $OE_USER/$OE_CONFIG/addons/"
echo "Start Odoo service: sudo service $OE_CONFIG start"
echo "Stop Odoo service: sudo service $OE_CONFIG stop"
echo "Restart Odoo service: sudo service $OE_CONFIG restart"
echo "-----------------------------------------------------------"
echo
echo
