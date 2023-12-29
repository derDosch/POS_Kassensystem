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


