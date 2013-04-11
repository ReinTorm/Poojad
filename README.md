                                                  Rakenduse paigaldamine
                                                        E-valimine


1. Lae alla(http://www.eclipse.org/downloads/) ja paigalda kõige uuem Eclipse Juno. 
2. Paigalda eclipse järgmised pluginad( Help -> Install New Software -> https://dl.google.com/eclipse/plugin/4.2) : Google App Engine Java SDK 1.7.7, Google Web Toolkit 2.5.1. ,Google Plugin for Eclipse.
3. Lehelt http://www.oracle.com/technetwork/java/javase/downloads/index.html lae alla JDK 7 ning paigalda see Eclipse:

Window -> Preferences -> Java -> installed JREs -> Add... -> JDK 1.7.0
4. Projekti lisamine Eclipse :

File -> Import... -> General -> Existing Projects into Workspace -> Select archive file: (valida Poojad-masters.zip) -> Finish
5. Google+ API lisamine projektile:

evalimineuus -> Google -> Add Google APIs... -> lisada Google+ API
6. Projekti seadistamine Eclipses(kui projektis on probleeme) :

evalimineuus -> Build path -> Configure build path... -> eemaldada com.google.gdt.eclipse.* library ja muuta JRE System Library JDK 1.7.0_x
evalimineuus -> Run as -> Run configurations... -> GWT -> Available Modules -> Add... -> Evalimine -> com.evalimine.uus
7. Rakenduse jooksutamine:

evalimineuus -> Run as -> Web application
  
