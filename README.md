
# pos_point_of_sale_system

Point of Sale (POS) System App

The Point of Sale System App is a Flutter application designed as a foundation for managing a Point of Sale system. The app allows users to manage product information, make purchases, and edit the shopping cart.

## Features
### Product Management
- Add, edit, and delete products.
- Each product includes information such as name, price, availability in stock, unit, currency, and an optional image.

  

### Shopping Cart
- Add products from the product list to the shopping cart.
- The cart displays a preview of the added products with their prices and allows users to increase or decrease the quantity of items.

### Payment Processing
- Enter the total amount and complete the payment.
- The amount to be paid is calculated and displayed.
- Enter the amount of money and receive information about the change or the remaining amount.

## Architecture and Used Packages
- Flutter for cross-platform development.
- Architecture based on the Provider package for state management.
- SQFLite package for local storage of product and shopping cart information.
- SharedPreferences for storing product information.

## Usage
### Setting up the Development Environment
1. Install Flutter: See Getting Started.
2. Clone the repository.
3. Run "flutter pub get" in the terminal to download all necessary dependencies.

## Authors
- Philip Dosch

## License
- This project is licensed under the MIT License. Details can be found in the LICENSE file.

## Getting Started
### Install Android Studio and Open Flutter Project

#### Installing Android Studio
1. Download Android Studio from the official website.
2. Installation:
   - Windows: Double-click the downloaded file and follow the instructions.
   - macOS: Drag the downloaded Android Studio program into the "Applications" folder.
   - Linux: Unpack the archive and follow the installation instructions for your OS.

#### Installing an Android version for simulation
1. Open Android Studio and click on "Configure" > "AVD Manager" in the toolbar.
2. Click "Create Virtual Device," select a device (e.g., Pixel 3), and click "Next."
3. Choose a system image version, download it, and configure the virtual device.
4. Click "Finish" to complete the installation.

#### Opening Flutter Project in Android Studio
1. Launch Android Studio.
2. Install Flutter plugin (if not already installed): Go to "File" > "Settings" > "Plugins," search for "Flutter," and install the plugin.
3. Go to "File" > "Open" and select the folder of your Flutter project.
4. Click the green "Play" button to start the project.

### Alternative IDEs - Visual Studio Code
1. Launch Visual Studio Code.
2. Install Flutter plugin: Go to "Extensions" (or press Ctrl + Shift + X), search for "Flutter," and install the plugin.
3. Go to "File" > "Open Folder" and select the folder of your Flutter project.
4. Use the command palette (Ctrl + Shift + P) and type "Flutter: Run" to start the project.









# pos_kassensystem

Kassensystem-App

    Die Kassensystem-App ist eine Flutter-Anwendung, die als Grundlage für die Verwaltung eines POS (Point-of-Sale)-Systems dient. 
    Die App ermöglicht es Benutzern, Produktinformationen zu verwalten, Einkäufe durchzuführen und den Warenkorb zu bearbeiten.

Funktionen
    Produktverwaltung

        Die App bietet Funktionen zur Verwaltung von Produkten, einschließlich Hinzufügen, Bearbeiten und Löschen von Produkten. 
        Jedes Produkt enthält Informationen wie Name, Preis, Verfügbarkeit im Lager, Einheit, Währung und ein optionales Bild. 

   Warenkorb

        Benutzer können Produkte aus der Produktliste in den Warenkorb legen. 
        Der Warenkorb zeigt eine Vorschau der hinzugefügten Produkte mit ihren Preisen und ermöglicht es, 
        die Anzahl der Artikel zu erhöhen oder zu verringern.

   Zahlungsabwicklung

        Der Zahlungsbildschirm erlaubt es dem Benutzer, den Gesamtbetrag einzugeben und die Bezahlung abzuschließen. 
        Dabei wird der zu zahlende Betrag berechnet und angezeigt. 
        Der Benutzer kann die Geldsumme eingeben und erhält Informationen über das Rückgeld oder den fehlenden Betrag.

Architektur und verwendete Pakete

    Die App verwendet Flutter für die plattformübergreifende Entwicklung. 
    Die Architektur basiert auf dem Provider-Paket für das State-Management. 
    Die Datenbankinteraktion wird durch das SQFLite-Paket für die lokale Speicherung von Produkt- und Warenkorbinformationen durchgeführt.
    Zudem wird SharedPreferences für die Speicherung von Produktinformationen genutzt.
   
   Verwendung

Einrichtung der Entwicklungsumgebung

    Installieren von Flutter: Siehe getting Started
    Klone das Repository.
    Führe "flutter pub get" in dem Terminal aus, um alle benötigten Abhängigkeiten herunterzuladen.

Autoren

    Philip Dosch

Lizenz

    Dieses Projekt ist unter der MIT-Lizenz lizenziert. Details findest du in der LICENSE-Datei.

## Getting Started

Android Studio installieren und Flutter-Projekt öffnen


Installation von Android Studio

    Android Studio herunterladen: Lade die neueste Version von Android Studio von der offiziellen Website herunter.
    Installation von Android Studio:
        Windows: Doppelklicke auf die heruntergeladene Datei und folge den Anweisungen im Installationsassistenten.
        macOS: Ziehe das heruntergeladene Android Studio-Programm in den "Applications"-Ordner.
        Linux: Entpacke das Archiv und folge den Anweisungen der Installationsanleitung für dein Betriebssystem.

Installation einer Android-Version für die Simulation

    Öffne Android Studio und klicke auf "Configure" > "AVD Manager" in der Toolbar oder suche nach "AVD Manager" in der Suchleiste.
    Klicke auf "Create Virtual Device", wähle ein Gerät aus der Liste aus (z.B. Pixel 3), und klicke auf "Next".
    Wähle eine System-Image-Version aus: Lade eine Android-Version herunter, indem du auf "Download" neben der gewünschten Android-Version klickst.
    Konfiguriere das virtuelle Gerät nach Bedarf (z.B. RAM-Größe, Speicher usw.).
    Klicke auf "Finish", um die Installation der virtuellen Android-Version abzuschließen.

Android Studio öffnen des Flutter-Projekts

    Android Studio öffnen: Starte Android Studio.
    Flutter-Plugin installieren (falls noch nicht installiert): Gehe zu "File" > "Settings" > "Plugins". Suche nach "Flutter" und installiere das Plugin.
    Flutter-Projekt öffnen: Gehe zu "File" > "Open" und wähle den Ordner deines Flutter-Projekts aus.
    Projekt ausführen: Klicke auf den grünen "Play"-Button in der oberen Leiste, um das Projekt zu starten.

Alternative IDEs
Visual Studio Code

    Visual Studio Code öffnen: Starte Visual Studio Code.
    Flutter-Plugin installieren (falls noch nicht installiert): Gehe zu "Extensions" (oder drücke Ctrl + Shift + X), suche nach "Flutter" und installiere das Plugin.
    Flutter-Projekt öffnen: Gehe zu "File" > "Open Folder" und wähle den Ordner deines Flutter-Projekts aus.
    Projekt ausführen: Verwende die Befehlsleiste (Ctrl + Shift + P) und tippe "Flutter: Run" ein, um das Projekt zu starten.


