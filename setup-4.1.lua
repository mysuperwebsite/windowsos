local function getColourOf(hex)
        local value = tonumber(hex, 16)
        if not value then return nil end
    value = math.pow(2,value)
    return value
end

local function drawPictureTable(image, xinit, yinit, alpha)
        if not alpha then alpha = 1 end
        for y=1,#image do
                for x=1,#image[y] do
                        term.setCursorPos(xinit + x-1, yinit + y-1)
                        local col = getColourOf(string.sub(image[y], x, x))
                        if not col then col = alpha end
                        term.setBackgroundColor(col)
                        term.write(" ")
                end
        end
end

function limitRead(nLimit, replaceChar)
		term.setCursorBlink(true)
        local cX, cY = term.getCursorPos()
        local rString = ""
        if replaceChar == "" then replaceChar = nil end
        repeat
                local event, p1 = os.pullEvent()
                if event == "char" then
                        -- Character event
                        if #rString + 1 <= nLimit then
                                rString = rString .. p1
                                write(replaceChar or p1)
                        end
                elseif event == "key" and p1 == keys.backspace and #rString >= 1 then
                        -- Backspace
                        rString = string.sub(rString, 1, #rString-1)
                        xPos, yPos = term.getCursorPos()
                        term.setCursorPos(xPos-1, yPos)
                        write(" ")
                        term.setCursorPos(xPos-1, yPos)
                end
        until event == "key" and p1 == keys.enter
        term.setCursorBlink(false)
        print() -- Skip to the next line after clicking enter.
        return rString
end

shell.run("cd /")

local startupFile = [[
local version = "4.1"

local function getColourOf(hex)
        local value = tonumber(hex, 16)
        if not value then return nil end
    value = math.pow(2,value)
    return value
end

local function drawPictureTable(image, xinit, yinit, alpha)
        if not alpha then alpha = 1 end
        for y=1,#image do
                for x=1,#image[y] do
                        term.setCursorPos(xinit + x-1, yinit + y-1)
                        local col = getColourOf(string.sub(image[y], x, x))
                        if not col then col = alpha end
                        term.setBackgroundColor(col)
                        term.write(" ")
                end
        end
end

function limitRead(nLimit, replaceChar)
		term.setCursorBlink(true)
        local cX, cY = term.getCursorPos()
        local rString = ""
        if replaceChar == "" then replaceChar = nil end
        repeat
                local event, p1 = os.pullEvent()
                if event == "char" then
                        -- Character event
                        if #rString + 1 <= nLimit then
                                rString = rString .. p1
                                write(replaceChar or p1)
                        end
                elseif event == "key" and p1 == keys.backspace and #rString >= 1 then
                        -- Backspace
                        rString = string.sub(rString, 1, #rString-1)
                        xPos, yPos = term.getCursorPos()
                        term.setCursorPos(xPos-1, yPos)
                        write(" ")
                        term.setCursorPos(xPos-1, yPos)
                end
        until event == "key" and p1 == keys.enter
        term.setCursorBlink(false)
        print() -- Skip to the next line after clicking enter.
        return rString
end

local function centerText(text)
	local x, y = term.getCursorPos()
	local w, h = term.getSize()
	term.setCursorPos(math.floor((w - #text) / 2) + 1, y)
	term.write(text)
end

local start = function()
	shell.run("clear")
	local logo = {
		"eeeeeeee 55555555";
		"eeeeeeee 55555555";
		"eeeeeeee 55555555";
		"eeeeeeee 55555555";
		"eeeeeeee 55555555";
		"eeeeeeee 55555555";
		"eeeeeeee 55555555";
        "                 ";
		"bbbbbbbb 11111111";
		"bbbbbbbb 11111111";
		"bbbbbbbb 11111111";
		"bbbbbbbb 11111111";
		"bbbbbbbb 11111111";
		"bbbbbbbb 11111111";
		"bbbbbbbb 11111111";
	}
	
	drawPictureTable(logo, 15, 2, colors.white)
	
	-- restore background color
	term.setBackgroundColor(colors.black)
end

local load = function()
	local i = 1
	while i <= 10 do
		term.setCursorPos(23,18)
		print(":")
		sleep(0.1)
		term.setCursorPos(23,18)
		print("/")
		sleep(0.1)
		term.setCursorPos(23,18)
		print("-")
		sleep(0.1)
		i = i + 1
	end
end

local function login()
	if fs.exists("/windows/login.nfp") then
		local image = paintutils.loadImage("/windows/login.nfp")
		paintutils.drawImage(image, 1, 1)
	else
		term.setBackgroundColor(colors.blue)
		shell.run("clear")
	end
	
	term.setBackgroundColor(colors.white)
	term.setCursorPos(1,6)
	local usersFiles = fs.list("/windows/users")
	local x, y = term.getCursorPos()
	local i = 4
	while i <= 12 do
		paintutils.drawLine(16,i,35,i,colors.white)
		i = i + 1
	end
	i = 6
	while i <= 8 do
		paintutils.drawLine(17,i,34,i,colors.gray)
		i = i + 1
	end
	term.setTextColor(colors.black)
	for file, _ in ipairs(usersFiles) do
		term.setCursorPos(17,y)
		term.setTextColor(colors.white)
		print(_)
	end
	term.setCursorPos(1,4)
	term.setBackgroundColor(colors.white)
	term.setTextColor(colors.black)
	centerText(" Benutzer auswählen ")
	term.setCursorPos(1,10)
	term.setBackgroundColor(colors.lightGray)
	centerText("            ")
	while true do
		local event, button, X, Y = os.pullEvent("mouse_click");
		
		if X >= 17 and X <= 34 and Y == 6 then
			passwordLogin(usersFiles[1])
		elseif X >= 17 and X <= 34 and Y == 7 then
			passwordLogin(usersFiles[2])
		elseif X >= 17 and X <= 34 and Y == 8 then
			passwordLogin(usersFiles[3])
		end
		
		break
	end
end

function passwordLogin(username)
	local w, h = term.getSize()
	local usersT = fs.open("windows/users/"..username, "r")
	local rPassword = usersT.readAll()
	usersT.close()
	if rPassword == "" then
		term.setBackgroundColor(colors.blue)
		shell.run("clear")
		
		term.setCursorPos(1,10)
		term.setTextColour(colors.white)
		centerText("Willkommen, "..username.."!")
		return
	end
	term.setCursorPos(math.floor(( w - #"            ") / 2 ) + 1,10)
	term.setCursorBlink(true)
	local password = limitRead(12)
	
	if rPassword == password then
		term.setBackgroundColor(colors.blue)
		shell.run("clear")
		
		term.setCursorPos(1,10)
		term.setTextColour(colors.white)
		centerText("Willkommen, "..username.."!")
	else
		term.setBackgroundColor(colors.blue)
		term.setTextColor(colors.white)
		shell.run("clear")
		term.setCursorPos(1,8)
		centerText("Passwort falsch!")
		term.setCursorPos(1,10)
		term.setBackgroundColor(colors.gray)
		centerText("    ")
		term.setCursorPos(1,10)
		centerText("OK")
			
		while true do
			local event, button, X, Y = os.pullEvent("mouse_click")
				
			local firstX = math.floor(( w - #"    ") / 2 ) + 1
				
			if X >= firstX and X <= firstX + 3 and Y == 10 then
				os.reboot()
				break
			end
		end
	end
end

-- ENDE DES VORDESKTOP-TEIL VOM CODE

-- BEGINN DES DESKTOP-TEIL VOM CODE

local function makeWindow(title)
	term.redirect(term.native())
	term.setBackgroundColor(colors.white)
	term.clear()
	term.setCursorPos(1,1)
	term.setBackgroundColor(colors.gray)
	term.setTextColor(colors.white)
	write("                                                  ")
	print("X")
	term.setCursorPos(1,1)
	print(title)
	term.setCursorPos(1,2)
	term.setBackgroundColor(colors.white)
	
	term.setCursorPos(1,19)
	term.setBackgroundColor(colors.white)
	write(" ")
	term.setBackgroundColor(colors.gray)
	write("                                                  ")
	term.setBackgroundColor(colors.white)
	
	local myWindow = window.create(term.current(), 1, 2, 51, 17)
	term.redirect(myWindow)
	myWindow.setBackgroundColor(colors.white)
	myWindow.setTextColor(colors.black)
	myWindow.clear()
end

local function WExplorer()
	local function redraw()
	makeWindow("WExplorer")
	print("Freier Speicher: "..fs.getFreeSpace("/"))
	shell.run("ls")
	end
	
	redraw()
	
	while true do
		local event, button, X, Y = os.pullEvent("mouse_click")
		
		if button == 1 then
			if X == 51 and Y == 1 then
				break
			end
		elseif button == 2 then
			-- Kontextmenü
			local rightCM = window.create(term.current(), X, Y, 11, 7)
			term.redirect(rightCM)
			term.setBackgroundColor(colors.gray)
			term.clear()
			term.setCursorPos(1,1)
			write("Neu")
			term.setCursorPos(1,2)
			write("Ausführen")
		    term.setCursorPos(1,3)
			write("Löschen")
			term.setCursorPos(1,4)
			write("Kopieren")
			term.setCursorPos(1,5)
			write("Verschieben")
			term.setCursorPos(1,6)
			write("Verzeichnis")
			term.setCursorPos(1,7)
			write("Hauptverz.")
			local Yo = Y + 1
			local rightCW = true
			while rightCW == true do
				local event, button, X, Y = os.pullEvent("mouse_click")
				
				if Yo == Y then
					term.redirect(term.native())
					redraw()
					local renameW = window.create(term.current(),14,7,25,3)
					term.redirect(renameW)
					print("Programm benennen")
					term.setCursorPos(2,2)
					local progName = read()
					makeWindow("Edit")
					shell.run("edit",progName)
					redraw()
					break
				elseif (Yo+1) == Y then
					term.redirect(term.native())
					redraw()
					local renameW = window.create(term.current(),14,7,25,3)
					term.redirect(renameW)
					print("Programmname eingeben")
					term.setCursorPos(2,2)
					local progName = read()
					makeWindow(progName)
					term.setBackgroundColor(colors.black)
					term.setTextColor(colors.white)
					term.clear()
					term.setCursorPos(1,1)
					shell.run(progName)
					redraw()
					break
				elseif (Yo+2) == Y then
					term.redirect(term.native())
					redraw()
					local renameW = window.create(term.current(),14,7,25,3)
					term.redirect(renameW)
					print("Datei zum Löschen angeben")
					term.setCursorPos(2,2)
					local progName = read()
					fs.delete(progName)
					redraw()
					break
				elseif (Yo+3) == Y then
					term.redirect(term.native())
					redraw()
					local renameW = window.create(term.current(),14,7,25,3)
					term.redirect(renameW)
					print("Datei zum Kopieren angeben")
					term.setCursorPos(2,2)
					local progName = read()
					term.redirect(term.native())
					redraw()
					local renameW = window.create(term.current(),14,7,25,3)
					term.redirect(renameW)
					print("Ziel angeben")
					term.setCursorPos(2,2)
					local dest = read()
					fs.copy(progName, dest)
					redraw()
					break
				elseif (Yo+4) == Y then
					term.redirect(term.native())
					redraw()
					local renameW = window.create(term.current(),14,7,25,3)
					term.redirect(renameW)
					print("Datei zum Versch. angeben")
					term.setCursorPos(2,2)
					local progName = read()
					term.redirect(term.native())
					redraw()
					local renameW = window.create(term.current(),14,7,25,3)
					term.redirect(renameW)
					print("Ziel angeben")
					term.setCursorPos(2,2)
					local dest = read()
					fs.move(progName, dest)
					redraw()
					break
				elseif (Yo+5) == Y then
					term.redirect(term.native())
					redraw()
					local renameW = window.create(term.current(),14,7,25,3)
					term.redirect(renameW)
					print("Verzeichnis angeben")
					term.setCursorPos(2,2)
					local dir = read()
					shell.run("cd", dir)
					redraw()
					break
				elseif (Yo+6) == Y then
					term.redirect(term.native())
					shell.run("cd /")
					redraw()
					break
				else
					redraw()
					break
				end
			end
		end
	end
end

cmdApp = function()
	makeWindow("Eingabeauffoderung")
	term.setBackgroundColor(colors.black)
	shell.run("clear")
	shell.run("shell")
end

gamesApp = function()
	makeWindow("Spiele")
	term.setBackgroundColor(colors.black)
	term.setTextColor(colors.white)
	shell.run("clear")
	
	local gamesLocation = "/rom/programs/fun/"
	
	term.setCursorPos(1,2)
	term.setBackgroundColor(colors.red)
	print("                                                   ")
	print("                                                   ")
	print("                                                   ")
	term.setCursorPos(1,6)
	print("                                                   ")
	print("                                                   ")
	print("                                                   ")
	
	term.setCursorPos(1,10)
	print("                                                   ")
	print("                                                   ")
	print("                                                   ")
	
	term.setCursorPos(1,3)
	centerText("Worm")
	
	term.setCursorPos(1,7)
	centerText("Adventure")
	
	term.setCursorPos(1,11)
	centerText("Redirection")
	
	while true do
		local event, button, X, Y = os.pullEvent("mouse_click")
		
		if X >= 1 and X <= 51 and Y == 3 or Y == 4 or Y == 5 then
			term.redirect(term.native())
			term.setBackgroundColor(colors.black)
			term.setTextColor(colors.white)
			shell.run("clear")
			shell.run(gamesLocation.."worm")
			break
		elseif X >= 1 and X <= 51 and Y == 7 or Y == 8 or Y == 9 then
			term.redirect(term.native())
			term.setBackgroundColor(colors.black)
			term.setTextColor(colors.white)
			shell.run("clear")
			shell.run(gamesLocation.."adventure")
			break
		elseif X >= 1 and X <= 51 and Y == 11 or Y == 12 or Y == 13 then
			term.redirect(term.native())
			term.setBackgroundColor(colors.black)
			term.setTextColor(colors.white)
			shell.run("clear")
			shell.run(gamesLocation.."advanced/redirection")
			break
		elseif X == 51 and Y == 1 then
			break
		end
	end
end

settingsApp = function()
	local function redraw()	
		makeWindow("Einstellungen")
		
		term.setCursorPos(1,2)
		print("Einstellungen anpassen\n")
		
		write(" ")
		term.setBackgroundColor(colors.black)
		write(" ")
		term.setBackgroundColor(colors.white)
		print("  Benutzer")
		
		print()
		write(" ")
		term.setBackgroundColor(colors.black)
		write(" ")
		term.setBackgroundColor(colors.white)
		print("  Deinstallieren")
		
		print()
		write(" ")
		term.setBackgroundColor(colors.black)
		write(" ")
		term.setBackgroundColor(colors.white)
		print("  Personalisierung")
		
		print()
		write(" ")
		term.setBackgroundColor(colors.black)
		write(" ")
		term.setBackgroundColor(colors.white)
		print("  Startmedium")
		
		print()
		write(" ")
		term.setBackgroundColor(colors.black)
		write(" ")
		term.setBackgroundColor(colors.white)
		print("  Geräte-Manager")
	end
	
	userAccounts = function()
		local function redrawMainMenu()
			term.setBackgroundColor(colors.blue)
			shell.run("clear")
			term.setCursorPos(1,2)
			term.setTextColor(colors.white)
			print("Was wollen Sie tun?\n")
			
			write(" ")
			term.setBackgroundColor(colors.black)
			write(" ")
			term.setBackgroundColor(colors.blue)
			print("  Benutzer löschen\n")
			
			write(" ")
			term.setBackgroundColor(colors.black)
			write(" ")
			term.setBackgroundColor(colors.blue)
			print("  Benutzerinfos ändern\n")
			
			write(" ")
			term.setBackgroundColor(colors.black)
			write(" ")
			term.setBackgroundColor(colors.blue)
			print("  Neuen Benutzer erstellen")
		end
		changeUserInfo = function()
			
			term.setBackgroundColor(colors.blue)
			shell.run("clear")
			term.setCursorPos(1,2)
			term.setTextColor(colors.white)
			print("Bitte geben Sie den Namen des Benutzers ein:\n")
			term.setBackgroundColor(colors.white)
			term.setTextColor(colors.black)
			write("                                              ")
			term.setCursorPos(1, 4)
			local input = read()
			term.setBackgroundColor(colors.blue)
			shell.run("clear")
			term.setCursorPos(1,2)
			term.setTextColor(colors.white)
			print("Was wollen Sie tun?\n")
			
			write(" ")
			term.setBackgroundColor(colors.black)
			write(" ")
			term.setBackgroundColor(colors.blue)
			print("  Benutzernamen ändern\n")
			
			write(" ")
			term.setBackgroundColor(colors.black)
			write(" ")
			term.setBackgroundColor(colors.blue)
			print("  Passwort ändern\n")
				
			while true do
				local event, button, X, Y = os.pullEvent("mouse_click")
					
				if X == 2 and Y == 5 then
					term.setBackgroundColor(colors.blue)
					shell.run("clear")
					
					print("Neuen Namen des Benutzers eingeben:\n")
					term.setBackgroundColor(colors.white)
					term.setTextColor(colors.black)
					write("                                              ")
					
					term.setCursorPos(1, 3)
					local newUserName = read()
					
					shell.run("rename windows/users/"..input.." "..newUserName)
					term.setBackgroundColor(colors.blue)
					term.setTextColor(colors.white)
					print("\nBenutzername wurde verändert.")
					sleep(2)
					redrawMainMenu()
					break
				elseif X == 2 and Y == 7 then
					term.setBackgroundColor(colors.blue)
					shell.run("clear")
					
					print("Altes Passwort eingeben:\n")
					term.setBackgroundColor(colors.white)
					term.setTextColor(colors.black)
					write("                                              ")
					
					term.setCursorPos(1, 3)
					local oldPassWord = read()
					term.setBackgroundColor(colors.blue)
					term.setTextColor(colors.white)
					local usersT = fs.open("windows/users/"..input, "r")
					local rPassword = usersT.readAll()
					
					if oldPassWord == rPassword then
					else
						print("\nPasswort falsch!")
						sleep(2)
						redrawMainMenu()
						break
					end
					
					print("Neues Passwort eingeben:\n")
					term.setBackgroundColor(colors.white)
					term.setTextColor(colors.black)
					write("                                              ")
					term.setCursorPos(1, 6)
					local newPassWord = read()
					
					local userLocation = fs.open("windows/users/"..input, "w")
					userLocation.writeLine(newPassWord)
					userLocation.flush()
					userLocation.close()
					print("\nPasswort wurde verändert.")
					sleep(2)
					redrawMainMenu()
					break
				elseif X == 2 and Y == 7 then
					break
				end
			end
		end
		makeWindow("Benutzer")
		
		redrawMainMenu()
		
		while true do
			local event, button, X, Y = os.pullEvent("mouse_click")
			
			if X == 2 and Y == 5 then
				term.setBackgroundColor(colors.blue)
				shell.run("clear")
				term.setCursorPos(1,2)
				term.setTextColor(colors.white)
				print("Bitte geben Sie den Namen des Benutzers ein:\n")
				term.setBackgroundColor(colors.white)
				term.setTextColor(colors.black)
				write("                                              ")
				term.setCursorPos(1, 4)
				local input = read()
				term.setBackgroundColor(colors.blue)
				term.setTextColor(colors.white)
				shell.run("delete /windows/users/"..input)
				print("\nBenutzer wurde gelöscht.")
				sleep(2)
				redrawMainMenu()
			elseif X == 2 and Y == 7 then
				changeUserInfo()
			elseif X == 2 and Y == 9 then
				term.setBackgroundColor(colors.blue)
				shell.run("clear")
				term.setCursorPos(1,2)
				term.setTextColor(colors.white)
				print("Namen des neuen Benutzers eingeben:\n")
				term.setBackgroundColor(colors.white)
				term.setTextColor(colors.black)
				write("                                              ")
				term.setCursorPos(1, 4)
				local uName = read()
				term.setBackgroundColor(colors.blue)
				term.setTextColor(colors.white)
				print("Passwort des neuen Benutzers eingeben:\n")
				term.setBackgroundColor(colors.white)
				term.setTextColor(colors.black)
				write("                                              ")
				term.setCursorPos(1, 7)
				local pWord = read()
				term.setBackgroundColor(colors.blue)
				term.setTextColor(colors.white)
				local userLocation = fs.open("/windows/users/"..uName, "w")
				userLocation.writeLine(pWord)
				userLocation.flush()
				userLocation.close()
				print("\nBenutzer wurde erstellt.")
				sleep(2)
				redrawMainMenu()
			elseif X == 51 and Y == 1 then
				break
			end
		end
	end
	
	deinstallieren = function()
		makeWindow("Windows deinstallieren")
		
		print("Hiermit können Sie Windows deinstallieren.")
		print("Sie können es jederzeit auch neuinstallieren.")
		print("Folgendes wird gelöscht: ")
		print("* Benutzer")
		print("* Windows OS")
		print()
		print("Klicken Sie auf Weiter um den Vorgang fortzusetzen.")
		print()
		term.setBackgroundColor(colors.lightGray)
		term.setTextColor(colors.white)
		centerText(" Weiter ")
		local w, h = term.getSize()
		local firstX = math.floor(( w - #"        ") / 2 ) + 1
		while true do
			local event, button, X, Y = os.pullEvent("mouse_click")
			
			if X >= firstX and X <= firstX + 7 and Y == 10 then
				term.redirect(term.native())
				term.setBackgroundColor(colors.black)
				term.setTextColor(colors.white)
				shell.run("clear")
				print("Windows OS wird deinstalliert...")
				print("Dateien werden gelöscht")
				shell.run("delete /startup")
				shell.run("delete /windows/users")
				shell.run("delete /windows/*")
				shell.run("delete /windows")
				print("Deinstallieren abgeschlossen.")
				print("Wird neu gestartet")
				sleep(1)
				os.reboot()
			elseif X == 51 and Y == 1 then
				term.setBackgroundColor(colors.white)
				term.setTextColor(colors.black)
				break
			end
		end
	end
	
	personalisierung = function()
		apperanceMain = function()
			makeWindow("Personalisierung")
			
			print()
			write(" ")
			term.setBackgroundColor(colors.lightGray)
			term.setTextColor(colors.white)
			print("Hintergrund ändern")
			term.setBackgroundColor(colors.white)
			term.setTextColor(colors.black)
			
			print()
			write(" ")
			term.setBackgroundColor(colors.lightGray)
			term.setTextColor(colors.white)
			print("Loginhintergrund ändern")
			term.setBackgroundColor(colors.white)
			term.setTextColor(colors.black)
		end
		
		apperanceMain()
		
		while true do
			local event, button, X, Y = os.pullEvent("mouse_click")
			
			if X >= 2 and X <= 19 and Y == 3 then
				term.redirect(term.native())
				shell.run("paint /windows/bg")
				apperanceMain()
			elseif X >= 2 and X <= 24 and Y == 5 then
				term.redirect(term.native())
				shell.run("paint /windows/login")
				apperanceMain()
			elseif X == 51 and Y == 1 then
				term.setBackgroundColor(colors.white)
				term.setTextColor(colors.black)
				break
			end
		end
	end

	startDisk = function()
		page1 = function()
			makeWindow("Startmedium")
			print()
			print("Dieses Tool kann für Ihnen ein Windows OS-Start")
			print("medium erstellen. Es kann benutzt werden, falls")
			print("Windows OS nicht mehr funktioniert und Windows OS")
			print("neuzuinstallieren. Es ist kein Sicherungs-Tool.")
			print()
			print("Klicken Sie auf \"Weiter\" um den Vorgang fortzusetzen.")
			
			term.setBackgroundColor(colors.lightGray)
			term.setTextColor(colors.white)
			term.setCursorPos(43, 16)
			write(" Weiter ")
			term.setBackgroundColor(colors.white)
			term.setTextColor(colors.black)
			
			while true do
				local event, button, X, Y = os.pullEvent("mouse_click")
				
				if X >= 43 and X <= 50 and Y == 17 then
					page2()
				elseif X == 51 and Y == 1 then
					term.setBackgroundColor(colors.white)
					term.setTextColor(colors.black)
					break
				end
			end
		end
		
		page2 = function()
			shell.run("clear")
			print()
			print("Legen Sie eine leeres Medium ein und klicken Sie auf \"Weiter\".")
			print("ACHTUNG: Alle Daten auf dem Medium werden gelöscht!")
			
			term.setBackgroundColor(colors.lightGray)
			term.setTextColor(colors.white)
			term.setCursorPos(43, 16)
			write(" Weiter ")
			term.setBackgroundColor(colors.white)
			term.setTextColor(colors.black)
			
			while true do
				local event, button, X, Y = os.pullEvent("mouse_click")
				
				if X >= 43 and X <= 50 and Y == 17 then
					page3()
				elseif X == 51 and Y == 1 then
					term.setBackgroundColor(colors.white)
					term.setTextColor(colors.black)
					break
				end
			end
		end
		
		page3 = function()
			shell.run("clear")
			print()
			print("Startmedium wird erstellt...")
			fs.copy("/windows/startupDisk", "/disk/startup")
		end
		
		page4 = function()
			shell.run("clear")
			print()
			print("Die Erstellung ist abgeschlossen.")
			
			term.setBackgroundColor(colors.lightGray)
			term.setTextColor(colors.white)
			term.setCursorPos(50-16, 16)
			write(" Fertig stellen ")
			term.setBackgroundColor(colors.white)
			term.setTextColor(colors.black)
			
			while true do
				local event, button, X, Y = os.pullEvent("mouse_click")
				
				if X >= 50-16 and X <= 50 and Y == 17 then
					term.setBackgroundColor(colors.white)
					term.setTextColor(colors.black)
					break
				elseif X == 51 and Y == 1 then
					term.setBackgroundColor(colors.white)
					term.setTextColor(colors.black)
					break
				end
			end
		end
		
		page1()
	end
	
	deviceMan = function()
		makeWindow("Geräte-Manager")
		
		shell.run("clear")
		
		if peripheral.getType("top") == "modem" then
			print("Modem: Vorhanden")
		elseif peripheral.getType("bottom") == "modem" then
			print("Modem: Vorhanden")
		elseif peripheral.getType("left") == "modem" then
			print("Modem: Vorhanden")
		elseif peripheral.getType("right") == "modem" then
			print("Modem: Vorhanden")
		elseif peripheral.getType("back") == "modem" then
			print("Modem: Vorhanden")
		else
			print("Modem: Nicht vorhanden!")
		end
		
		print()
		write("Diskettenlaufwerk: ")
		if fs.exists("/disk") then
			write(fs.getFreeSpace("/"))
			print(" Bytes frei")
		else
			print("Nicht vorhanden / Keine eingelegt!")
		end
		
		print()
		write("Festplattenlaufwerk: ")
		write(fs.getFreeSpace("/"))
		print(" Bytes frei")
		
		while true do
			local event, button, X, Y = os.pullEvent("mouse_click")
			
			if X == 51 and Y == 1 then
				term.setTextColor(colors.white)
				break
			end
		end
	end
	
	redraw()
	
	while true do
		local event, button, X, Y = os.pullEvent("mouse_click")
		
		if X == 2 and Y == 5 then
			userAccounts()
			redraw()
		elseif X == 2 and Y == 7 then
			deinstallieren()
			redraw()
		elseif X == 2 and Y == 9 then
			personalisierung()
			redraw()
		elseif X == 2 and Y == 11 then
			startDisk()
			redraw()
		elseif X == 2 and Y == 13 then
			deviceMan()
			redraw()
		elseif X == 51 and Y == 1 then
			term.setTextColor(colors.white)
			break
		end
	end
end

downloaderApp = function()
	local function redraw()
		makeWindow("Windows OS-Erweiterungen")
		
		term.setCursorPos(1,2)
		print("Downloads:\n")
		
		write(" ")
		term.setBackgroundColor(colors.black)
		write(" ")
		term.setBackgroundColor(colors.white)
		print("  LuaIDE")
		
		print()
		write(" ")
		term.setBackgroundColor(colors.black)
		write(" ")
		term.setBackgroundColor(colors.white)
		print("  CC Browser")
		
		print()
		write(" ")
		term.setBackgroundColor(colors.black)
		write(" ")
		term.setBackgroundColor(colors.white)
		print("  Manuell")
	end
	
	redraw()
	
	while true do
		local event, button, X, Y = os.pullEvent("mouse_click")
		
		if X == 2 and Y == 5 then
			shell.run("clear")
			if fs.exists("/luaide") then
				term.redirect(term.native())
				shell.run("/luaide")
				redraw()
			else
				print("LuaIDE wird heruntergeladen...")
				local response = http.get("https://pastebin.com/raw/vyAZc6tJ")
				
				if response then
					print("Download erfolgreich!")
					print()
					print("Die Datei kann von dieser Anwendung aus gestartet werden!")
					local sResponse = response.readAll()
					response.close()
					local datei = fs.open("/luaide", "w")
					datei.write(sResponse)
					datei.close()
					sleep(2)
					redraw()
				else
					print("Download fehlgeschlagen!")
					sleep(2)
					redraw()
				end
			end
		elseif X == 2 and Y == 7 then
			shell.run("clear")
			if fs.exists("/ccBrowser") then
				term.redirect(term.native())
				shell.run("/ccBrowser")
				redraw()
			else
				print("CC Browser wird heruntergeladen...")
				local response = http.get("https://pastebin.com/raw/XFqcTqLJ")
				
				if response then
					print("Download erfolgreich!")
					print()
					print("Die Datei kann von dieser Anwendung aus gestartet werden!")
					local sResponse = response.readAll()
					response.close()
					local datei = fs.open("/ccBrowser", "w")
					datei.write(sResponse)
					datei.close()
					sleep(2)
					redraw()
				else
					print("Download fehlgeschlagen!")
					sleep(2)
					redraw()
				end
			end
		elseif X == 2 and Y == 9 then
			shell.run("clear")
			print("Pastebin Code eingeben: ")
			paintutils.drawLine(1,2,51,2,colors.gray)
			term.setCursorPos(1,2)
			term.setTextColor(colors.white)
			local pastebinCode = read()
			term.setBackgroundColor(colors.white)
			term.setTextColor(colors.black)
			shell.run("clear")
			print("Dateiname eingeben: ")
			paintutils.drawLine(1,2,51,2,colors.gray)
			term.setCursorPos(1,2)
			term.setTextColor(colors.white)
			local dateiName = read()
			term.setBackgroundColor(colors.white)
			term.setTextColor(colors.black)
			shell.run("clear")
			print("Pastebin "..pastebinCode.." wird heruntergeladen...")
			local response = http.get("https://pastebin.com/raw/"..textutils.urlEncode(pastebinCode))
				
			if response then
				print("Download erfolgreich!")
				print()
				print("Die Datei kann von der Eingabeauffoderung aus gestartet werden!")
				local sResponse = response.readAll()
				response.close()
				local datei = fs.open("/"..dateiName, "w")
				datei.write(sResponse)
				datei.close()
				sleep(2)
				redraw()
			else
				print("Download fehlgeschlagen!")
				sleep(2)
				redraw()
			end
		elseif X == 51 and Y == 1 then
			term.setTextColor(colors.white)
			break
		end
	end
end

local function backupApp()
	makeWindow("Sicherung")
	shell.run("clear")
	
	local function backupMode()
		shell.run("clear")
		print("Verzeichnis für Sicherung angeben:")
		print()
		write(" ")
		term.setBackgroundColor(colors.lightGray)
		term.setTextColor(colors.white)
		print("                                  ")
		term.setCursorPos(2, 3)
		local source = limitRead(34)
		term.setBackgroundColor(colors.white)
		term.setTextColor(colors.black)
		print()
		print("Speicherort angeben:")
		print()
		write(" ")
		term.setBackgroundColor(colors.lightGray)
		term.setTextColor(colors.white)
		print("                                  ")
		term.setCursorPos(2, 3)
		local destination = limitRead(34)
		term.setBackgroundColor(colors.white)
		term.setTextColor(colors.black)
		print()
		shell.run("clear")
		print("Dateien werden kopiert...")
		shell.run("copy "..source.."/* "..destination)
		shell.run("clear")
		print("Sicherung abgeschlossen!")
		print()
		write(" ")
		term.setBackgroundColor(colors.lightGray)
		term.setTextColor(colors.white)
		print(" OK ")
		term.setBackgroundColor(colors.white)
		term.setTextColor(colors.black)
		
		while true do
			local event, button, X, Y = os.pullEvent("mouse_click")
			
			if X >= 2 and X <= 5 and Y == 8 then
				page1()
			elseif X == 51 and Y == 1 then
				term.setTextColor(colors.white)
				break
			end
		end
	end
	
	local function restoreMode()
		shell.run("clear")
		print("Verzeichnis von der Sicherung angeben:")
		print()
		write(" ")
		term.setBackgroundColor(colors.lightGray)
		term.setTextColor(colors.white)
		print("                                  ")
		term.setCursorPos(2, 3)
		local source = limitRead(34)
		term.setBackgroundColor(colors.white)
		term.setTextColor(colors.black)
		print()
		print("Speicherort der Sicherung angeben:")
		print()
		write(" ")
		term.setBackgroundColor(colors.lightGray)
		term.setTextColor(colors.white)
		print("                                  ")
		term.setCursorPos(2, 3)
		local destination = limitRead(34)
		term.setBackgroundColor(colors.white)
		term.setTextColor(colors.black)
		print()
		shell.run("clear")
		print("Dateien werden kopiert...")
		shell.run("copy "..source.."/* "..destination)
		shell.run("clear")
		print("Wiederherstellung abgeschlossen!")
		print()
		write(" ")
		term.setBackgroundColor(colors.lightGray)
		term.setTextColor(colors.white)
		print(" OK ")
		term.setBackgroundColor(colors.white)
		term.setTextColor(colors.black)
		
		while true do
			local event, button, X, Y = os.pullEvent("mouse_click")
			
			if X >= 2 and X <= 5 and Y == 8 then
				page1()
			elseif X == 51 and Y == 1 then
				term.setTextColor(colors.white)
				break
			end
		end
	end
	
	local function page1()
		print("Dieses Programme sichert ihre Windows-OS Konfiguration.")
		print("Falls Sie Windows OS neuinstallieren, können Sie hier Ihre")
		print("Dateien wiederherstellen.")
		print()
		print("Wählen Sie einen Modus:")
		print()
		write(" ")
		term.setBackgroundColor(colors.lightGray)
		term.setTextColor(colors.white)
		print(" Sichern ")
		term.setBackgroundColor(colors.white)
		term.setTextColor(colors.black)
		print()
		write(" ")
		term.setBackgroundColor(colors.lightGray)
		term.setTextColor(colors.white)
		print(" Wiederherstellen ")
		term.setBackgroundColor(colors.white)
		term.setTextColor(colors.black)
		
		while true do
			local event, button, X, Y = os.pullEvent("mouse_click")
			
			if X >= 2 and X <= 10 and Y == 8 then
				backupMode()
			elseif X >= 2 and X <= 18 and Y == 10 then
				restoreMode()
			elseif X == 51 and Y == 1 then
				term.setTextColor(colors.white)
				break
			end
		end
	end
	
	page1()
end

local function zubehoerGruppe()
	makeWindow("Zubehör")
	shell.run("clear")
	
	while true do
		-- WExplorer
		local iconA1 = "2,3"
		local iconA2 = "2,4"
		local iconA3 = "2,5"
		local iconA4 = "3,3"
		local iconA5 = "3,4"
		local iconA6 = "3,5"
		local iconA7 = "4,3"
		local iconA8 = "4,4"
		local iconA9 = "4,5"
		
		-- Shell
		local iconB1 = "6,3"
		local iconB2 = "6,4"
		local iconB3 = "6,5"
		local iconB4 = "7,3"
		local iconB5 = "7,4"
		local iconB6 = "7,5"
		local iconB7 = "8,3"
		local iconB8 = "8,4"
		local iconB9 = "8,5"
		
		-- Spiele
		local iconC1 = "10,3"
		local iconC2 = "10,4"
		local iconC3 = "10,5"
		local iconC4 = "11,3"
		local iconC5 = "11,4"
		local iconC6 = "11,5"
		local iconC7 = "12,3"
		local iconC8 = "12,4"
		local iconC9 = "12,5"
		
		-- Sicherung
		local iconD1 = "14,3"
		local iconD2 = "14,4"
		local iconD3 = "14,5"
		local iconD4 = "15,3"
		local iconD5 = "15,4"
		local iconD6 = "15,5"
		local iconD7 = "16,3"
		local iconD8 = "16,4"
		local iconD9 = "16,5"
		
		-- Paint
		local iconE1 = "18,3"
		local iconE2 = "18,4"
		local iconE3 = "18,5"
		local iconE4 = "19,3"
		local iconE5 = "19,4"
		local iconE6 = "19,5"
		local iconE7 = "20,3"
		local iconE8 = "20,4"
		local iconE9 = "20,5"
		
		local expIcon = paintutils.loadImage("windows/explorer.nfp")
		paintutils.drawImage(expIcon, 2, 2)
		
		local expIcon = paintutils.loadImage("windows/shell.nfp")
		paintutils.drawImage(expIcon, 6, 2)
		
		local expIcon = paintutils.loadImage("windows/games.nfp")
		paintutils.drawImage(expIcon, 10, 2)
		
		local expIcon = paintutils.loadImage("windows/backup.nfp")
		paintutils.drawImage(expIcon, 14, 2)
		
		local expIcon = paintutils.loadImage("windows/paint.nfp")
		paintutils.drawImage(expIcon, 18, 2)
	
		local event, button, X, Y = os.pullEvent("mouse_click")
		local XY = X..","..Y
		
		if XY == iconA1 or XY == iconA2 or XY == iconA3 or XY == iconA4 or XY == iconA5 or XY == iconA6 or XY == iconA7 or XY == iconA8 or XY == iconA9 then
			WExplorer()
			break
		elseif XY == iconB1 or XY == iconB2 or XY == iconB3 or XY == iconB4 or XY == iconB5 or XY == iconB6 or XY == iconB7 or XY == iconB8 or XY == iconB9 then
			cmdApp()
			break
		elseif XY == iconC1 or XY == iconC2 or XY == iconC3 or XY == iconC4 or XY == iconC5 or XY == iconC6 or XY == iconC7 or XY == iconC8 or XY == iconC9 then
			gamesApp()
			break
		elseif XY == iconD1 or XY == iconD2 or XY == iconD3 or XY == iconD4 or XY == iconD5 or XY == iconD6 or XY == iconD7 or XY == iconD8 or XY == iconD9 then
			backupApp()
			break
		elseif XY == iconE1 or XY == iconE2 or XY == iconE3 or XY == iconE4 or XY == iconE5 or XY == iconE6 or XY == iconE7 or XY == iconE8 or XY == iconE9 then
			makeWindow("Paint")
			shell.run("clear")
			print("Willkommen bei Paint!")
			print()
			print("Geben Sie einen Dateinamen ein: ")
			print()
			term.setBackgroundColor(colors.lightGray)
			term.setTextColor(colors.white)
			write(" ")
			print("                                  ")
			print()
			term.setBackgroundColor(colors.white)
			term.setTextColor(colors.black)
			print("Geben Sie back ein, um zum Desktop zurückzukehren")
			term.setCursorPos(1, 5)
			term.setBackgroundColor(colors.lightGray)
			term.setTextColor(colors.white)
			local name = read()
			if name == "back" then
				break
			end
			term.redirect(term.native())
			term.setBackgroundColor(colors.black)
			term.setTextColor(colors.white)
			shell.run("clear")
			shell.run("paint "..name)
			break
		elseif X == 51 and Y == 1 then
			break
		end
	end
end

local function systemGruppe()
	makeWindow("System")
	shell.run("clear")
	
	while true do
		-- Einstellungen
		local iconD1 = "2,3"
		local iconD2 = "2,4"
		local iconD3 = "2,5"
		local iconD4 = "3,3"
		local iconD5 = "3,4"
		local iconD6 = "3,5"
		local iconD7 = "4,3"
		local iconD8 = "4,4"
		local iconD9 = "4,5"
		
		-- Download-Manager
		local iconE1 = "6,3"
		local iconE2 = "6,4"
		local iconE3 = "6,5"
		local iconE4 = "7,3"
		local iconE5 = "7,4"
		local iconE6 = "7,5"
		local iconE7 = "8,3"
		local iconE8 = "8,4"
		local iconE9 = "8,5"
	
		local expIcon = paintutils.loadImage("windows/settings.nfp")
		paintutils.drawImage(expIcon, 2, 2)
		
		local expIcon = paintutils.loadImage("windows/downloader.nfp")
		paintutils.drawImage(expIcon, 6, 2)
	
		local event, button, X, Y = os.pullEvent("mouse_click")
		local XY = X..","..Y
		
		if XY == iconD1 or XY == iconD2 or XY == iconD3 or XY == iconD4 or XY == iconD5 or XY == iconD6 or XY == iconD7 or XY == iconD8 or XY == iconD9 then
			settingsApp()
			break
		elseif XY == iconE1 or XY == iconE2 or XY == iconE3 or XY == iconE4 or XY == iconE5 or XY == iconE6 or XY == iconE7 or XY == iconE8 or XY == iconE9 then
			downloaderApp()
			break
		elseif X == 51 and Y == 1 then
			term.setTextColor(colors.white)
			break
		end
	end
end

main = function()
	local function redraw()
		shell.run("clear")
		local bg = paintutils.loadImage("windows/bg")
		paintutils.drawImage(bg, 1, 1)
		
		term.setCursorPos(1,19)
		term.setBackgroundColor(colors.white)
		write(" ")
		term.setBackgroundColor(colors.gray)
		write("                                                  ")
		
		local expIcon = paintutils.loadImage("windows/explorer.nfp")
		paintutils.drawImage(expIcon, 2, 14)
		
		local expIcon = paintutils.loadImage("windows/explorer.nfp")
		paintutils.drawImage(expIcon, 6, 14)
	end
	
	redraw()
	
	while true do
		local event, button, X, Y = os.pullEvent("mouse_click")
		local XY = X..","..Y
		
		-- Zubehörgruppe
		local iconA1 = "2,14"
		local iconA2 = "2,15"
		local iconA3 = "2,16"
		local iconA4 = "3,14"
		local iconA5 = "3,15"
		local iconA6 = "3,16"
		local iconA7 = "4,14"
		local iconA8 = "4,15"
		local iconA9 = "4,16"
		
		-- Systemgruppe
		local iconB1 = "6,14"
		local iconB2 = "6,15"
		local iconB3 = "6,16"
		local iconB4 = "7,14"
		local iconB5 = "7,15"
		local iconB6 = "7,16"
		local iconB7 = "8,14"
		local iconB8 = "8,15"
		local iconB9 = "8,16"
		
		--if X >= 2 and X <= 4 and Y == 14 or Y == 15 or Y == 16 then
		if XY == iconA1 or XY == iconA2 or XY == iconA3 or XY == iconA4 or XY == iconA5 or XY == iconA6 or XY == iconA7 or XY == iconA8 or XY == iconA9 then
			zubehoerGruppe()
			desktop()
			break
		elseif XY == iconB1 or XY == iconB2 or XY == iconB3 or XY == iconB4 or XY == iconB5 or XY == iconB6 or XY == iconB7 or XY == iconB8 or XY == iconB9 then
			systemGruppe()
			desktop()
			break
		elseif X == 1 and Y == 19 then
			term.setCursorPos(1,13)
			term.setBackgroundColor(colors.gray)
			
			print("--------------")
			term.setBackgroundColor(colors.lightGray)
			print("Informationen ")
			print("Ausführen     ")
			print("Abmelden      ")
			print("Beenden       ")
			term.setBackgroundColor(colors.gray)
			print("--------------")
			
			while true do
				local event, button, X, Y = os.pullEvent("mouse_click")
				
				if X >= 1 and X <= 14 and Y == 14 then
					redraw()
					term.setCursorPos(1, 8)
					term.setBackgroundColor(colors.black)
					centerText("Informationen")
					write(" X\n")
					term.setBackgroundColor(colors.white)
					w, h = term.getSize()
					term.setCursorPos(math.floor(( w - #"Informationen") / 2 ) + 1, 9)
					print("               ")
					term.setCursorPos(math.floor(( w - #"Informationen") / 2 ) + 1, 10)
					term.setTextColor(colors.black)
					print(" Windows "..version.."   ")
					term.setCursorPos(math.floor(( w - #"Informationen") / 2 ) + 1, 11)
					term.setTextColor(colors.white)
					print("               ")	
					while true do
						local event, button, X, Y = os.pullEvent("mouse_click")
						
						term.setBackgroundColor(colors.black)
						if X == 34 and Y == 8 then
							desktop()
							break
						end
					end
					break
				elseif X >= 1 and X <= 14 and Y == 15 then
					redraw()
					local renameW = window.create(term.current(),14,7,25,3)
					term.redirect(renameW)
					print("Programmname eingeben")
					term.setCursorPos(2,2)
					local progName = read()
					makeWindow(progName)
					term.setBackgroundColor(colors.black)
					term.setTextColor(colors.white)
					term.clear()
					term.setCursorPos(1,1)
					shell.run(progName)
					desktop()
				elseif X >= 1 and X <= 14 and Y == 16 then
					redraw()
					login()
					sleep(3)
					desktop()
					break
				elseif X >= 1 and X <= 14 and Y == 17 then
					term.setCursorPos(15,14)
					print("--------------")
					term.setBackgroundColor(colors.lightGray)
					term.setCursorPos(15,15)
					print("Herunterfahren")
					term.setCursorPos(15,16)
					print("Neu starten   ")
					term.setCursorPos(15,17)
					print("CraftOS-Modus ")
					term.setCursorPos(15,18)
					term.setBackgroundColor(colors.gray)
					print("--------------")
					
					while true do
						local event, button, X, Y = os.pullEvent("mouse_click")
						
						if X >= 15 and X <= 28 and Y == 15 then
							term.setTextColor(colors.white)
							term.setBackgroundColor(colors.blue)
							shell.run("clear")
							term.setCursorPos(1,10)
							centerText("Wird heruntergefahren")
							sleep(3)
							os.shutdown()
						elseif X >= 15 and X <= 28 and Y == 16 then
							term.setTextColor(colors.white)
							term.setBackgroundColor(colors.blue)
							shell.run("clear")
							term.setCursorPos(1,10)
							centerText("Wird neu gestartet")
							sleep(3)
							os.reboot()
						elseif X >= 15 and X <= 28 and Y == 17 then
							term.setBackgroundColor(colors.black)
							term.setTextColor(colors.white)
							shell.run("clear")
							shell.run("shell")
							print("Windows wird jetzt neu gestartet.")
							sleep(1)
							os.reboot()
						elseif X == 1 and Y == 19 then
							desktop()
							break
						end
					end
				elseif X == 1 and Y == 19 then
					desktop()
					break
				end
			end
			break
		end
	end
end

desktop = function()
	term.redirect(term.native())
	shell.run("clear")
	main()
end

-- Programmstart

start()
sleep(1)
load()
login()
sleep(2)
desktop()
]]

local startupDiskFile = [[
local menuItems = {}
local selectedItem = 1

function main()
    menuItems[1] = "Windows OS neuinstallieren"
    menuItems[2] = "CraftOS-Shell öffnen"
    menuItems[3] = "Neu starten"
    drawMenu()
    while true do
        local event, key = os.pullEvent("key")
        
        if key == keys.down then
            if selectedItem == table.getn(menuItems) then
            else
                selectedItem = selectedItem + 1
                drawMenu()
            end
        elseif key == keys.up then
            if selectedItem == 1 then
            else
                selectedItem = selectedItem - 1
                drawMenu()
            end
        elseif key == keys.enter then
            if selectedItem == 1 then
                shell.run("clear")
                print("Windows OS-Startmedium")
                print("======================")
                print()
                print("Geben Sie das Pastebin für die aktuelle")
                print("Windows OS-Version ein.")
                print()
                print("Windows-Versionen: ")
                print("https://pastebin.com/u/SkyNet_Pastes")
                print()
                write("Pastebin-Code: ")
                local pastebinCode = read()
                shell.run("clear")
                print("Windows OS-Startmedium")
                print("======================")
                print()
                shell.run("pastebin run "..pastebinCode)
                break
            elseif selectedItem == 2 then
                shell.run("clear")
                term.setTextColor(colors.yellow)
                print(os.version())
                break
            elseif selectedItem == 3 then
                os.reboot()
            end
        end
    end
end

function drawMenu()
    shell.run("clear")
    print("Windows OS-Startmedium")
    print("======================")
    print()
    print("Wählen Sie eine Option:")
    print()
    for _=1,table.getn(menuItems) do
        if selectedItem == _ then
            print("- "..menuItems[_])
        else
            print("* "..menuItems[_])
        end
    end
end

main()
]]

local explorerIcon = {
	"000";
	"111";
	"111";
}

local shellIcon = {
	"877";
	"787";
	"877";
}

local gamesIcon = {
	"ddf";
	"fdd";
	"fff";
}

local settingsIcon = {
	"787";
	"878";
	"787";
}

local downloaderIcon = {
	"ddd";
	"ddd";
	"bdb";
}

local backupIcon = {
	"000";
	"bbb";
	"bbb";
}

local paintIcon = {
	"8b8";
	"8b8";
	"888";
}

local background = {	
	"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb44444444444";
	"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb44444444444";
	"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb4444444444444";
	"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb44444444444444";
	"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb444444444444444";
	"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb444444444444444";
	"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb4444444444444444";
	"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb4444444444444444";
	"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb4444444444444888";
	"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb44444444444448888";
	"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb44444444444488888";
	"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb444444444444888888";
	"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb4444444444448888888";
	"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb44444444444488888888";
	"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbb444444444444888888888";
	"bbbbbbbbbbbbbbbbbbbbbbbbbbbbb4444444444448888888888";
	"bbbbbbbbbbbbbbbbbbbbbbbbbbb444444444444488888888888";
	"bbbbbbbbbbbbbbbbbbbbbbbbbb4444444444444888888888888";
	"bbbbbbbbbbbbbbbbbbbbbbbbbb4444444444444888888888888";
}

drawPictureTable(background, 1, 1, colors.white)

term.setCursorPos(2,2)
term.setBackgroundColor(colors.gray)
print("Windows installieren                  ")
term.setBackgroundColor(colors.white)
term.setCursorPos(2,3)
term.setTextColor(colors.black)
print(" Vielen Dank, dass Sie für Windows OS ")
term.setCursorPos(2,4)
print(" 4.1 entschieden haben.               ")
term.setCursorPos(2,5)
print(" Tippen Sie Ihre Benutzerdaten ein.   ")
term.setCursorPos(2,6)
print("                                      ")
term.setCursorPos(2,7)
print(" Benutzername:                        ")
term.setCursorPos(2,8)
write(" ")
term.setBackgroundColor(colors.lightGray)
write("           ")
term.setBackgroundColor(colors.white)
write("                          ")
term.setCursorPos(2,9)
print("                                      ")
term.setCursorPos(2,10)
print(" Kennwort:                            ")
term.setCursorPos(2,11)
write(" ")
term.setBackgroundColor(colors.lightGray)
write("           ")
term.setBackgroundColor(colors.white)
write("                          ")
term.setCursorPos(2,12)
print("                                      ")
term.setCursorPos(2,13)
print(" Kennwort wiederholen:                ")
term.setCursorPos(2,14)
write(" ")
term.setBackgroundColor(colors.lightGray)
write("           ")
term.setBackgroundColor(colors.white)
write("                          ")
term.setCursorPos(2,15)
print("                                      ")
term.setTextColor(colors.white)
term.setCursorPos(3,8)
term.setBackgroundColor(colors.lightGray)
local username = limitRead(11)
term.setCursorPos(3,11)
local password = limitRead(11)
term.setCursorPos(3,14)
local passwordConfirm = limitRead(11)

if username == "" then
	term.setBackgroundColor(colors.black)
	shell.run("clear")
	print("Leere Benutzernamen sind nicht erlaubt!")
	error()
end

if passwordConfirm == password then
	term.setBackgroundColor(colors.black)
	shell.run("clear")
	
	if fs.exists("/startup") then
		fs.delete("/startup")
		startupFileVar = fs.open("/startup", "w")
		startupFileVar.writeLine(startupFile)
		
		startupFileVar.flush()
		startupFileVar.close()
	else
		startupFileVar = fs.open("/startup", "w")
		startupFileVar.writeLine(startupFile)
		
		startupFileVar.flush()
		startupFileVar.close()
	end
	
	startupDisk = fs.open("/windows/startupDisk", "w")
	startupDisk.writeLine(startupDiskFile)
	
	startupDisk.flush()
	startupDisk.close()
	
	bg = fs.open("/windows/bg","w")
	
	for index, value in pairs(background) do
		bg.writeLine(value)
	end
	 
	bg.flush()
	bg.close()
	
	login = fs.open("/windows/login.nfp","w")
	
	for index, value in pairs(background) do
		login.writeLine(value)
	end
	 
	login.flush()
	login.close()
	 
	nfpExplorerIcon = fs.open("/windows/explorer.nfp", "w")
	 
	for index, value in pairs(explorerIcon) do
		nfpExplorerIcon.writeLine(value)
	end
	 
	nfpExplorerIcon.flush()
	nfpExplorerIcon.close()
	 
	nfpShellIcon = fs.open("/windows/shell.nfp", "w")
	 
	for index, value in pairs(shellIcon) do
		nfpShellIcon.writeLine(value)
	end
	 
	nfpShellIcon.flush()
	nfpShellIcon.close()
	 
	nfpGamesIcon = fs.open("/windows/games.nfp", "w")
	 
	for index, value in pairs(gamesIcon) do
		nfpGamesIcon.writeLine(value)
	end
	 
	nfpGamesIcon.flush()
	nfpGamesIcon.close()
	 
	nfpSettingsIcon = fs.open("/windows/settings.nfp", "w")
	 
	for index, value in pairs(settingsIcon) do
		nfpSettingsIcon.writeLine(value)
	end
	 
	nfpSettingsIcon.flush()
	nfpSettingsIcon.close()
	 
	nfpBackupIcon = fs.open("/windows/backup.nfp", "w")
	 
	for index, value in pairs(backupIcon) do
		nfpBackupIcon.writeLine(value)
	end
	 
	nfpBackupIcon.flush()
	nfpBackupIcon.close()
	 
	nfpDownloaderIcon = fs.open("/windows/downloader.nfp", "w")
	 
	for index, value in pairs(downloaderIcon) do
		nfpDownloaderIcon.writeLine(value)
	end
	 
	nfpDownloaderIcon.flush()
	nfpDownloaderIcon.close()
	
	nfpPaintIcon = fs.open("/windows/paint.nfp", "w")
	 
	for index, value in pairs(paintIcon) do
		nfpPaintIcon.writeLine(value)
	end
	 
	nfpPaintIcon.flush()
	nfpPaintIcon.close()
	
	shell.run("mkdir /windows/users")
 
	user = fs.open("/windows/users/"..username, "w")
	user.writeLine(password)
	 
	user.flush()
	user.close()
	
	shell.run("delete /.temp")
	
	os.reboot()
else
	term.setBackgroundColor(colors.black)
	shell.run("clear")
	print("Die Passwörter stimmen nicht überein!")
	error()
end