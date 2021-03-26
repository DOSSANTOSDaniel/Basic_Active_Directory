<#
NOM DU SCRIPT: script_ad.ps1			
*================================================================*
DESCRIPTION:

Ce script va nous permettre de: 

1* créer des unités d’organisation
2* créer des groupes
3* créer des utilisateurs

ATTENTION la création de ces objets se fait sur la racine efficom.local	
*================================================================*
AUTEUR: Daniel DOS SANTOS < daniel.massy91@gmail.com >			
*================================================================*
DATE DE CRÉATION: 02/03/2018	
*================================================================*
POWERSHELL VERSION: 5.1  
*================================================================*
#>

#Variables globales
$domaine = [ADSI]"LDAP://dc=efficom,dc=local"
$fin = 0

#Bannière
clear-host
$banniere = @"
______                          _          _ _ 
| ___ \                        | |        | | |
| |_/ /____      _____ _ __ ___| |__   ___| | |
|  __/ _ \ \ /\ / / _ \ '__/ __| '_ \ / _ \ | |
| | | (_) \ V  V /  __/ |  \__ \ | | |  __/ | |
\_|  \___/ \_/\_/ \___|_|  |___/_| |_|\___|_|_|
                                               
"@
write-host $banniere
write-host ""
write-host "-----------------------------------------"
write-host "*                                       *"
write-host "*             BIENVENUE                 *"
write-host "*                                       *"
write-host "*  Sur le serveur: << efficom.local >>  *"
write-host "*                                       *"
write-host "-----------------------------------------" 
write-host ""
sleep 4


while ($fin -ne 1)
{
clear-host
write-host "`nVeillez choisir une option :"
write-host ""
write-host "####################################" -f 'green'
write-host "                                    " -b 'black'
write-host "[1] Créer un utilisateur            " -f 'gray' -b 'black'
write-host "[2] Créer un groupe                 " -f 'gray' -b 'black'
write-host "[3] Créer une OU                    " -f 'gray' -b 'black'
write-host "[0] Fin                             " -f 'Magenta' -b 'black'
write-host "                                    " -b 'black'
write-host "####################################" -f 'green'
write-host ""

$choix = read-host "Votre choix : "

write-host ""

switch ($choix)
{  
    1 { 
        ###########_Création d'un utilisateur

        $util_pre = Read-Host "prénom du nouvel utilisateur"
        $util_nom = Read-Host "Nom du nouvel utilisateur"
        $util_sam = Read-Host "Nom sam"

        $utilisateur = $domaine.create("user","cn=$util_pre")  
        $utilisateur.put("samaccountName","$util_sam") 	 
        $utilisateur.put("sn","$util_nom") 	 
        $utilisateur.put("givenName","$util_pre") 	 
        $utilisateur.setInfo() 
        Read-Host "Validez pour continuer"
        write-Host "<< Fait >>"
        sleep 2
      }

    2 { 
        ###########_Création d'un groupe

        $groupe_n = Read-Host "Nom du nouveau groupe"
        $groupe_sam = Read-Host "Nom Sam"

        $groupe = $domaine.create("group","cn=$groupe_n") 	 
        $groupe.put("samaccountName","$groupe_sam") 	 
        $groupe.setinfo()
        Read-Host "Validez pour continuer"
        write-Host "<< Fait >>"
        sleep 2
      }

    3 { 
        ###########_Création d'une OU

        $ou = read-host "Nom de la nouvelle OU"
        $ou_desc = read-host "Description"
	 
        $organisation = $domaine.create("organizationalUnit","ou=$ou")  
        $organisation.put("description", "$ou_desc") 	 
        $organisation.setInfo()  
        Read-Host "Validez pour continuer"
        write-Host "<< Fait >>"
        sleep 2
      }

    0 { 
        Write-Host "######################" -f gray -b black
        Write-Host "##  " -f Gray -b Black -NoNewline;
        write-host "Fin du script" -f Red -b Black -NoNewline;
        write-host "   ##" -f gray -b black
        Write-Host "######################" -f gray -b black
        $fin = 1
       }

default
      { 
        Write-Host "##########################" -f Red -b black
        Write-Host "##   Erreur de syntaxe  ##" -f Red -b black
        Write-Host "## Veuillez recommencer ##" -f Red -b black
        Write-Host "##########################" -f Red -b black
        sleep 3
      }
}
}
