import java.net.URL;
import java.net.MalformedURLException;
import java.io.File;
import java.io.FileWriter;
import java.io.FileReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.BufferedInputStream;
import java.io.BufferedWriter;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.BufferedReader;
import java.lang.Byte;
import java.lang.StringBuilder;
import java.lang.Class
import java.lang.System;
import java.lang.reflect.Array;
import java.text.NumberFormat;
import java.util.Base64;
import java.util.zip.ZipFile;
import java.util.zip.ZipInputStream;
import net.md_5.bungee.api.ChatMessageType;
import net.md_5.bungee.api.chat.TextComponent;
import net.md_5.bungee.api.chat.ComponentBuilder;
import net.md_5.bungee.api.chat.ClickEvent;
import net.md_5.bungee.api.chat.ClickEvent$Action as ClickEventAction;
import net.md_5.bungee.api.chat.HoverEvent;
import net.md_5.bungee.api.chat.HoverEvent$Action as HoverEventAction;
import org.bukkit.configuration.file.YamlConfiguration;
import io.github.wysohn.gsoncopy.JsonParser;
import io.github.wysohn.gsoncopy.JsonObject;
import io.github.wysohn.gsoncopy.GsonBuilder;
import io.github.wysohn.triggerreactor.core.manager.Manager

clearChat = "\n&a\n&a\n&a\n&a\n&a\n&a\n&a\n&a\n&a\n&a\n&a\n&a\n&a\n&a\n&a\n&a\n&a\n&a\n&a\n&a\n&a\n&a\n&a\n&a\n&a\n&a\n&a\n&a\n&a\n&a\n&a\n&a\n&a\n&a\n&a\n&a\n&a\n&a\n&a\n&a\n&a\n&a\n&a\n&a\n&a\n&a\n&a\n&a\n&a\n&a\n&a\n&a\n&a\n&a\n&a\n&a\n&a\n&a\n&a\n&a\n&a\n&a\n&a\n&a\n&a\n&a\n&a\n&a\n&a\n&a\n&a\n&a\n&a\n&a\n&a\n&a\n&a\n&a\n&a\n&a\n&a\n&a\n&a\n&a\n&a\n&a\n&a\n&a\n&a\n&a\n&a\n&a\n&a\n&a\n&a\n&a\n&a\n&a\n&a\n&a"
breakLine = "\n";
in = "    ";
parser = JsonParser();
numberFormat = NumberFormat.getInstance();
gson = GsonBuilder().setPrettyPrinting().create();

triggerList = listOf("CommandTrigger", "CustomTrigger", "Executor", "InventoryTrigger", "NamedTriggers", "Placeholder", "RepeatTrigger", "Other")

yes = TextComponent("§a[YES]");
yes.setClickEvent(ClickEvent(ClickEventAction.RUN_COMMAND, "/github yes"));
yes.setHoverEvent(HoverEvent(HoverEventAction.SHOW_TEXT, ComponentBuilder("§aContinue Processes").create()));

no = TextComponent("§4[NO]");
no.setClickEvent(ClickEvent(ClickEventAction.RUN_COMMAND, "/github no"));
no.setHoverEvent(HoverEvent(HoverEventAction.SHOW_TEXT, ComponentBuilder("§cStop Processes").create()));

overwrite = TextComponent("§e[OverwriteAll]");
overwrite.setClickEvent(ClickEvent(ClickEventAction.RUN_COMMAND, "/github overwrite"));
overwrite.setHoverEvent(HoverEvent(HoverEventAction.SHOW_TEXT, ComponentBuilder("§aOverwrite all files").create()));

skip = TextComponent("§b[SkipAll]");
skip.setClickEvent(ClickEvent(ClickEventAction.RUN_COMMAND, "/github skip"));
skip.setHoverEvent(HoverEvent(HoverEventAction.SHOW_TEXT, ComponentBuilder("§bSkip all files").create()));

packagePath = "./plugins/TriggerReactor/packages";
package = File(packagePath);
packageFile = File(packagePath + "/packageManager.json");

IF !package.exists()
    package.mkdirs();
ENDIF

IF !packageFile.exists()
    packageFile.createNewFile();
ENDIF

packageReader = FileReader(packageFile);

TRY
    packageManager = parser.parse(packageReader).getAsJsonObject();
CATCH e
    packageManager = JsonObject();

    packageInfo = JsonObject();
    packageInfo.addProperty("name", "TRGithub");
    packageInfo.addProperty("version", "1.0.0-Release");
    packageInfo.addProperty("active", true);
    packageInfo.addProperty("path", "TRGithub-main");
    packageInfo.addProperty("url", "https://github.com/Cupelt/TRGithub");

    packageManager.add("trgithub", packageInfo);

    fw = FileWriter(packageFile);
    gson.toJson(packageManager, fw);
    fw.flush();
    fw.close();
ENDTRY

packageReader.close();

IF args.length == 0
    builder = StringBuilder();
    builder = builder.append("&b---------- &fTRGithub &b----------")
    builder = builder.append("\n&7./github active &8<packageName> &f| &achange active package");
    builder = builder.append("\n&7./github active &8<packageName> <overwrite | skip> &f| &aSet whether to overwrite.");
    builder = builder.append("\n&7./github package <packageName | *> &f| &ashow downloaded pakages");
    builder = builder.append("\n&7./github insatall &8<github repository url> &f| \n&aInstall the \"latest package\" from the github repository.");
    builder = builder.append("\n&7./github insatall &8<github repository url> <version> &f| \n&aInstall the \"selected version\" from the github repository.");
    builder = builder.append("\n&7./github insatall &8<packageName> &f| \n&aUpdate the \"latest package\" in github repository.");
    builder = builder.append("\n&7./github insatall &8<packageName> <version>&f| \n&aUpdate the \"selected version\" from the github repository.");
    builder = builder.append("\n&7./github export &f| &aSee &2\"./github export\"&a for more information");
    builder = builder.append("\n&7./github delete &8<packageName> &f| &aDelete the package");
    #MESSAGE builder
ENDIF

IF args.length == 1
    IF args[0] == "export"
        #MESSAGE "&cThe current version is a compressed version!"
        #MESSAGE "&cPlease update to a version that supports the export function!"
        #MESSAGE "&c/github install TRGithub"
    ELSEIF args[0] == "yes" && {?"users." + $playeruuid + ".choice"} == "none"
        {?"users." + $playeruuid + ".choice"} = "YES";
    ELSEIF args[0] == "no" && {?"users." + $playeruuid + ".choice"} == "none"
        {?"users." + $playeruuid + ".choice"} = "NO";
    ELSEIF args[0] == "overwrite" && {?"users." + $playeruuid + ".choice"} == "none"
        {?"users." + $playeruuid + ".choice"} = "overwrite";
    ELSEIF args[0] == "skip" && {?"users." + $playeruuid + ".choice"} == "none"
        {?"users." + $playeruuid + ".choice"} = "skip";
    ENDIF
ENDIF

IF args.length == 2
    IF args[0] == "package"

        builder = StringBuilder();
        IF args[1] == "*"
            FOR pack = packageManager.keySet()
                packjson = packageManager.getAsJsonObject(pack)
                
                TRY
                    verStream = InputStreamReader(URL("https://api.github.com/repos/" + packjson.get("url").getAsString().replaceAll("https://github.com/", "") + "/releases/latest").openStream());
                    latestVer = parser.parse(verStream).getAsJsonObject().get("tag_name").getAsString();
                CATCH e
                    IF e.getMessage() != null && e.getMessage().contains("Server returned HTTP response code: 403")
                        latestVer = "&cRequest limit exceeded."
                    ELSE
                        latestVer = "Unknwon or Deleted Repository";
                    ENDIF
                ENDTRY

                IF packjson.get("active").getAsBoolean();
                    active = "&aEnable";
                ELSE
                    active = "&cDisable"
                ENDIF

                IF pack == "trgithub"
                    builder = builder.insert(0, "\n" + in + "&7latest version &8: &6" + latestVer);
                    builder = builder.insert(0, "\n" + in + "&7version &8: &e" + packjson.get("version").getAsString());
                    builder = builder.insert(0, "\n&f- &b" + packjson.get("name").getAsString() + " &f| " + active);
                ELSE
                    builder = builder.append("\n&f- &b" + packjson.get("name").getAsString() + " &f| " + active);
                    builder = builder.append("\n" + in + "&7version &8: &e" + packjson.get("version").getAsString());
                    builder = builder.append("\n" + in + "&7latest version &8: &6" + latestVer);
                ENDIF
            ENDFOR
        ELSE
            packjson = packageManager.getAsJsonObject(args[1].toLowerCase())

            IF packjson !=null
                
                TRY
                    verStream = InputStreamReader(URL("https://api.github.com/repos/" + packjson.get("url").getAsString().replaceAll("https://github.com/", "") + "/releases/latest").openStream());
                    latestVer = parser.parse(verStream).getAsJsonObject().get("tag_name").getAsString();
                CATCH e
                    IF e.getMessage() != null && e.getMessage().contains("Server returned HTTP response code: 403")
                        latestVer = "&cRequest limit exceeded."
                    ELSE
                        latestVer = "Unknwon or Deleted Repository";
                    ENDIF
                ENDTRY

                TRY
                    zip = ZipFile(File("."+packjson.get("path").getAsString()));
                    parentDir = zip.entries().nextElement().getName();

                    infoEntry = zip.getEntry(parentDir+"package-info.json");
                    infoJson = parser.parse(InputStreamReader(zip.getInputStream(infoEntry)));
                    triggersJson = infoJson.getAsJsonObject("triggers");
                    infoJson = infoJson.getAsJsonObject("info");

                    IF packjson.get("active").getAsBoolean();
                        active = "&aEnable";
                    ELSE
                        active = "&cDisable";
                    ENDIF

                    builder = builder.append("\n&7Package Name &f: &b" + packjson.get("name").getAsString() + " &f| " + active);
                    builder = builder.append("\n&f\n&7Author &f- &d"+infoJson.get("author").getAsString());
                    builder = builder.append("\n&f\n&7Description &f- &f");
                    builder = builder.append("\n&8"+infoJson.get("description").getAsString())
                    builder = builder.append("\n&f\n&7version &f: &e" + packjson.get("version").getAsString());
                    builder = builder.append("\n&7latest version &f: &6" + latestVer);
                    builder = builder.append("\n&f\n&7Tested trg Version &f: &b" + infoJson.get("trg_version").getAsString());
                    builder = builder.append("\n&7Tested minecraft Version &f: &b" + infoJson.get("mc_version").getAsString());
                    builder = builder.append("\n&7Recommended Java Version &f: &b" + infoJson.get("jdk").getAsString());
                    builder = builder.append("\n&f\n&7Github url &f: &a&n" + packjson.get("url").getAsString());
                    builder = builder.append("\n&f\n&7Triggers &f-")
                    FOR trigger = triggersJson.keySet()
                        builder = builder.append("\n"+in+"&7" + trigger + " &f-")
                        builder = builder.append("\n"+in+"&2" + triggersJson.getAsJsonArray(trigger))
                    ENDFOR

                    zip.close();
                CATCH e
                    IF e.getClass() IS Class.forName("java.util.zip.ZipException");
                        #MESSAGE "&c.trgpack File is empty!";
                        #MESSAGE "&cIs there any damage to the file?";
                    ENDIF
                    e.printStackTrace();

                    TRY
                        zip.close();
                    CATCH e
                    ENDTRY
                    #STOP
                ENDTRY
            ELSE
                #MESSAGE "&c'"+args[1]+"' not found";
                #STOP
            ENDIF
        ENDIF
        builder.insert(0, "&b---------- &fTRGithub &b----------");
        #MESSAGE builder.toString();
    ENDIF
ENDIF

IF args.length == 2 || args.length == 3
    IF args.length == 2 && args[0] == "delete"
        packageJson = packageManager.getAsJsonObject(args[1].toLowerCase())
        IF packageJson != null
            IF args[1].toLowerCase() == "trgithub"
                #MESSAGE "&cTRGithub cannot be deleted!";
                #STOP;
            ENDIF
            beforePath = packageJson.get("path").getAsString();
            beforeFile = File("."+ beforePath);
            IF beforeFile.exists()
                #MESSAGE "&7Deleting files...";
                TRY
                    IF packageJson.get("active").getAsBoolean()
                        zip = ZipFile(beforeFile);
                        parentDir = zip.entries().nextElement().getName();

                        infoEntry = zip.getEntry(parentDir+"package-info.json");
                        infoJson = parser.parse(InputStreamReader(zip.getInputStream(infoEntry)));

                        #MESSAGE "&cDisabling '" + packageJson.get("name").getAsString() + "'...";
                        #WAIT 1;
                        FOR trigger = triggerList
                            trgJson = infoJson.getAsJsonObject("triggers").getAsJsonArray(trigger);
                            IF trgJson != null
                                FOR f = trgJson
                                    deletePath = "./plugins/TriggerReactor/"+trigger+"/"+f.getAsString();
                                    deleteFile = File(deletePath);
                                    deleteFile.delete()
                                    #MESSAGE "&cDeleted &4'"+ deletePath +"'";
                                ENDFOR
                            ENDIF
                        ENDFOR
                        packageJson.addProperty("active", false);
                        #MESSAGE "&cDisable Complete";
                        zip.close();
                    ENDIF

                    IF beforeFile.delete()
                        #MESSAGE "&cDeleted &4'"+ beforePath +"'"
                        packageManager.remove(args[1].toLowerCase())
                    ELSE
                        #MESSAGE "&4Failed to delete '.trgpack' file, Please restart the server and try again"
                        #MESSAGE "&cThere is no problem with the process,"
                        #MESSAGE "&cbut if it continues, please contact TRGithub issue."
                        #STOP
                    ENDIF
                CATCH e
                    IF e.getClass() IS Class.forName("java.util.zip.ZipException")
                        #MESSAGE "&c.trgpack File is empty!";
                        #MESSAGE "&cIs there any damage to the file?";
                    ENDIF
                    e.printStackTrace()
                    TRY
                        zip.close();
                    CATCH e
                    ENDTRY
                ENDTRY
            ENDIF

            #MESSAGE "&cDelete Complete &4'"+packageJson.get("name").getAsString()+"'"
            packageManager.remove(args[1].toLowerCase())
        ELSE
            #MESSAGE "&c'"+args[1]+"' not found";
        ENDIF
    ENDIF
    IF args[0] == "active"
        IF args.length == 3
            IF args[2].toLowerCase().contains("overwrite")
                isOverwrite = true;
            ELSEIF args[2].toLowerCase().contains("skip")
                isOverwrite = false;
            ELSE
                #MESSAGE "&cPlease only use overwrite or skip";
                #STOP;
            ENDIF
        ENDIF
        
        packageJson = packageManager.getAsJsonObject(args[1].toLowerCase())

        IF packageJson != null
            zip = ZipFile(File("."+ packageJson.get("path").getAsString()));
            parentDir = zip.entries().nextElement().getName();

            infoEntry = zip.getEntry(parentDir+"package-info.json");
            infoJson = parser.parse(InputStreamReader(zip.getInputStream(infoEntry)));

            TRY
                IF !packageJson.get("active").getAsBoolean()
                    #MESSAGE "&aEnabling '" + packageJson.get("name").getAsString() + "'..."; // Uncompressing
                    #WAIT 2;
                    FOR trigger = triggerList
                        trgJson = infoJson.getAsJsonObject("triggers").getAsJsonArray(trigger);
                        IF trgJson != null
                            FOR f = trgJson
                                originPath = trigger+"/"+f.getAsString();
                                copyPath = "plugins/TriggerReactor/"+originPath;
                                copyFile = File("./"+ copyPath);

                                IF !copyFile.getParentFile().exists()
                                    copyFile.getParentFile().mkdirs();
                                ENDIF

                                IF !copyFile.exists()
                                    copyFile.createNewFile();
                                ELSEIF isOverwrite == null
                                    {?"users." + $playeruuid + ".choice"} = "none";

                                    #MESSAGE clearChat;

                                    #MESSAGE "&cFound a file with the same name!";
                                    #MESSAGE "&cWhat would you do? &f| &8default : SKIP";
                                    #MESSAGE "&cFile Path : "+copyPath;

                                    player.spigot().sendMessage(ChatMessageType.CHAT, overwrite, TextComponent(" "), skip);
                                    FOR i = 0:61
                                        IF {?"users." + $playeruuid + ".choice"} == "overwrite"
                                            isOverwrite = true;
                                            #BREAK;
                                        ELSEIF {?"users." + $playeruuid + ".choice"} == "skip" || i >= 60
                                            isOverwrite = false;
                                            #BREAK;
                                        ENDIF
                                        #WAIT 1;
                                    ENDFOR
                                ENDIF

                                IF isOverwrite == false
                                    #CONTINUE
                                ENDIF

                                originStream = BufferedInputStream(zip.getInputStream(zip.getEntry(parentDir + originPath)));
                                output = FileOutputStream(copyFile);
                                
                                count = originStream.read();
                                copyInput = FileInputStream(copyFile);
                                WHILE count != -1
                                    output.write(count);
                                    count = originStream.read();
                                    msg =  "§bUncompressing.. §f| §e" + numberFormat.format(copyInput.available()) + " byte §6/ §e" + numberFormat.format(originStream.available() + copyInput.available()) + " byte";
                                    player.spigot().sendMessage(ChatMessageType.ACTION_BAR, TextComponent(msg));
                                ENDWHILE
                                #MESSAGE "&bUncompressed &2'"+ originPath +"' §f| §e" + numberFormat.format(originStream.available() + copyInput.available()) + " byte"
                                output.close();
                                originStream.close();
                                copyInput.close();
                                
                            ENDFOR
                        ENDIF
                    ENDFOR

                    packageJson.addProperty("active", true);
                    #MESSAGE "&aEnable Complete";
                ELSE
                    IF args[1].toLowerCase() == "trgithub"
                        #MESSAGE "&cTRGithub cannot be disabled!";
                        #STOP;
                    ENDIF
                    #MESSAGE "&cDisabling '" + packageJson.get("name").getAsString() + "'...";
                    #WAIT 2;
                    FOR trigger = triggerList
                        trgJson = infoJson.getAsJsonObject("triggers").getAsJsonArray(trigger);
                        IF trgJson != null
                            FOR f = trgJson
                                deletePath = "./plugins/TriggerReactor/"+trigger+"/"+f.getAsString();
                                deleteFile = File(deletePath);
                                deleteFile.delete()
                                #MESSAGE "&cDeleted &4'"+ deletePath +"'";
                            ENDFOR
                        ENDIF
                    ENDFOR
                    packageJson.addProperty("active", false);
                    #MESSAGE "&cDisable Complete";
                ENDIF

                #MESSAGE "&eReloading TriggerReactor...";
                SYNC
                    FOR manager = Manager.getManagers()
                        manager.reload();
                    ENDFOR
                ENDSYNC
                #MESSAGE "&aReload Complete TriggerReactor!";
            CATCH e
                #MESSAGE "&cAn error has occurred!\nPlease check the console for details";
                #LOG e
            ENDTRY

            zip.close();
        ELSE
            #MESSAGE "&c'"+args[1]+"' not found";
        ENDIF
    ENDIF
ENDIF

IF args.length > 0 && args.length < 4
    IF args[0] == "install"
        IF args.length == 1
             #MESSAGE "&cPlease enter url";
            #STOP
        ENDIF

        path = args[1];

        packageJson = packageManager.getAsJsonObject(args[1].toLowerCase())

        IF packageJson != null
            IF args.length == 2
                #CMD "github install " + packageJson.get("url").getAsString()
                #STOP
            ELSEIF args.length == 3
                #CMD "github install " + packageJson.get("url").getAsString() + " " +  args[2]
                #STOP
            ENDIF
        ENDIF

        IF !path.contains("https://")
            path = "https://" + path;
        ENDIF
        
        #MESSAGE "&7Checking repository..."; // check repo is trgpackage
        #WAIT 1;

        TRY
            IF !path.contains("https://github.com/")
                #MESSAGE "&cPlease enter &4\"github\" &crepository url";
                #STOP
            ENDIF

            TRY 
                url = URL("https://raw.githubusercontent.com/" + path.replaceAll("https://github.com/", "") + "/master/package-info.json");
                stream = InputStreamReader(url.openStream());
                info = parser.parse(stream).getAsJsonObject().getAsJsonObject("info");
                name = info.get("name").getAsString();
            CATCH e
                #MESSAGE "&cThis repository is not TriggerReactor Package!";
                #STOP
            ENDTRY

            versionUrl = URL("https://api.github.com/repos/" + path.replaceAll("https://github.com/", "") + "/tags");
            tagStream = InputStreamReader(versionUrl.openStream());
            tags = parser.parse(tagStream).getAsJsonArray();
            IF tags.size() <= 0
                #MESSAGE "&cNo release in repository!";
                #STOP;
            ENDIF
            tagStream.close();

            IF args.length == 3 && args[2] != ""
                FOR tag = tags
                    IF tag.get("name").getAsString() == args[2];
                        versionJson = tag;
                        version = tag.get("name").getAsString();
                        #BREAK;
                    ENDIF
                ENDFOR

                IF version == null
                    {?"users." + $playeruuid + ".choice"} = "none";

                    #MESSAGE clearChat;

                    #MESSAGE "&cCould not find version '"+args[2]+"'";
                    #MESSAGE "&cDo you want to download the latest version?";

                    player.spigot().sendMessage(ChatMessageType.CHAT, yes, TextComponent(" "), no);
                    FOR i = 0:61
                        IF {?"users." + $playeruuid + ".choice"} == "YES"
                            #BREAK;
                        ELSEIF {?"users." + $playeruuid + ".choice"} == "NO"
                            #MESSAGE "&cProcesses canceled.";
                            #STOP;
                        ELSEIF i >= 60
                            #MESSAGE "&cTimeouted.";
                            #STOP;
                        ENDIF
                        #WAIT 1;
                    ENDFOR
                ENDIF
            ENDIF
            
            IF version == null
                versionUrl = URL("https://api.github.com/repos/" + path.replaceAll("https://github.com/", "") + "/releases/latest");
                verStream = InputStreamReader(versionUrl.openStream());
                versionJson = parser.parse(verStream).getAsJsonObject();
                version = versionJson.get("tag_name").getAsString();

                verStream.close();
            ENDIF

            #MESSAGE "&7Checking Server Directory..."; // check already exists
            #WAIT 1;

            downloadUrl = URL(versionJson.get("zipball_url").getAsString());
            
            IF packageManager.getAsJsonObject(name.toLowerCase()) != null && packageManager.getAsJsonObject(name.toLowerCase()).get("version").getAsString() == version
                {?"users." + $playeruuid + ".choice"} = "none";
                
                #MESSAGE "&c'" + name + "' was already exists!";
                #MESSAGE "&cDo you want to continue this Processes?";

                player.spigot().sendMessage(ChatMessageType.CHAT, yes, TextComponent(" "), no);
                FOR i = 0:61
                    IF {?"users." + $playeruuid + ".choice"} == "YES"
                        #BREAK;
                    ELSEIF {?"users." + $playeruuid + ".choice"} == "NO"
                        #MESSAGE "&cProcesses canceled.";
                        #STOP;
                    ELSEIF i >= 60
                        #MESSAGE "&cTimeouted.";
                        #STOP;
                    ENDIF
                    #WAIT 1;
                ENDFOR
            ENDIF

            IF packageManager.getAsJsonObject(name.toLowerCase()) != null
                beforePath = packageManager.getAsJsonObject(name.toLowerCase()).get("path").getAsString();
                beforeFile = File("./"+ beforePath);
                IF beforeFile.exists()
                    #MESSAGE "&7Deleting old files...";
                    TRY
                        IF packageManager.getAsJsonObject(args[1].toLowerCase()).get("active").getAsBoolean()
                            zip = ZipFile(File("."+ packageManager.getAsJsonObject(name.toLowerCase()).get("path").getAsString()));
                            parentDir = zip.entries().nextElement().getName();

                            infoEntry = zip.getEntry(parentDir+"package-info.json");
                            infoJson = parser.parse(InputStreamReader(zip.getInputStream(infoEntry)));

                            #MESSAGE "&cDisabling '" + packageManager.getAsJsonObject(name.toLowerCase()).get("name").getAsString() + "'...";
                            #WAIT 2;
                            FOR trigger = triggerList
                                trgJson = infoJson.getAsJsonObject("triggers").getAsJsonArray(trigger);
                                IF trgJson != null
                                    FOR f = trgJson
                                        deletePath = "./plugins/TriggerReactor/"+trigger+"/"+f.getAsString();
                                        deleteFile = File(deletePath);
                                        deleteFile.delete()
                                        #MESSAGE "&cDeleted &4'"+ deletePath +"'";
                                    ENDFOR
                                ENDIF
                            ENDFOR

                            zip.close()
                        ENDIF

                    CATCH e
                        IF e.getClass() IS Class.forName("java.util.zip.ZipException")
                            #MESSAGE "&c.trgpack File is empty!"
                            #MESSAGE "&cIs there any damage to the file?";
                        ENDIF
                    FINALLY
                        TRY
                            zip.close();
                        CATCH e
                        ENDTRY
                    ENDTRY

                    IF beforeFile.delete()
                        #MESSAGE "&cDeleted &4'"+ beforePath +"'"
                    ELSE
                        #MESSAGE "&4Failed to delete old '.trgpack' file"
                        #MESSAGE "&cThere is no problem with the process,"
                        #MESSAGE "&cbut if it continues, please contact TRGithub issue."
                    ENDIF
                    #WAIT 2;
                ENDIF
            ENDIF

            downloadPath = "/plugins/TriggerReactor/packages/" + name + " " + version + ".trgpack";
            downloadStream = BufferedInputStream(downloadUrl.openStream());

            downloadFile = File("./"+ downloadPath);

            IF !downloadFile.getParentFile().exists()
                downloadFile.getParentFile().mkdirs();
            ENDIF

            IF !downloadFile.exists()
                downloadFile.createNewFile();
            ENDIF

            output = FileOutputStream(downloadFile);

            #MESSAGE "&7downloading file form &8'" + path +"'..."; // start download
            count = downloadStream.read();
            downloadInput = FileInputStream(downloadFile);
            WHILE count != -1
                output.write(count);
                count = downloadStream.read();
                msg =  "§bDownloading §f| §e" + numberFormat.format(downloadInput.available()) + " byte §6/ §e" + numberFormat.format(downloadStream.available() + downloadInput.available()) + " byte";
                player.spigot().sendMessage(ChatMessageType.ACTION_BAR, TextComponent(msg));
            ENDWHILE
            #MESSAGE "&bDownloaded &2'"+ name + " " + version + ".trgpack' §f| §e" + numberFormat.format(downloadStream.available() + downloadInput.available()) + " byte"; // end download
            output.close();
            downloadStream.close();
            downloadInput.close();

            active = false

            IF packageManager.getAsJsonObject(name.toLowerCase()) != null
                IF packageManager.getAsJsonObject(name.toLowerCase()).get("active").getAsBoolean()
                    allowActive = true
                ELSE
                    allowActive = false
                ENDIF
            ENDIF

            packageInfo = JsonObject();
            packageInfo.addProperty("name", name);
            packageInfo.addProperty("active", active);
            packageInfo.addProperty("version", version);
            packageInfo.addProperty("path", downloadPath);
            packageInfo.addProperty("url", path);

            packageManager.add(name.toLowerCase(), packageInfo);
        CATCH e
            IF e.getMessage() != null && e.getMessage().contains("Server returned HTTP response code: 403")
                #MESSAGE "&cServer returned HTTP response code: 403";
                #MESSAGE "&cLooks like Github has put you in a time-out!"
                #MESSAGE "&cIt's okay, we all have those days when we get a little too excited and exceed our limits."
                #MESSAGE "&cTake a break, grab a cup of coffee, and try again later when Github is feeling a bit more forgiving.";
            ELSE
                #MESSAGE "&cAn error has occurred!\nPlease check the console for details";
                e.printStackTrace()
            ENDIF
        ENDTRY
    ENDIF
ENDIF

fw = FileWriter(packageFile);
gson.toJson(packageManager, fw);
fw.flush();
fw.close();

IF allowActive
    #CMD "github active "+name+" overwrite"
ENDIF
