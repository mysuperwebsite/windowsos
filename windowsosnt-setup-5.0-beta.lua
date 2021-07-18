local controllua = [[
local kernel32 = dofile("/winnt/kernel32.dll")
local kernel32 = dofile("/winnt/gdi32.dll")
local version = kernel32_returnVersion()

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
					
					shell.run("rename winnt/users/"..input.." "..newUserName)
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
					local usersT = fs.open("winnt/users/"..input, "r")
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
					
					local userLocation = fs.open("winnt/users/"..input, "w")
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
				shell.run("delete /winnt/users/"..input)
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
				local userLocation = fs.open("/winnt/users/"..uName, "w")
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
				shell.run("delete /winnt/users")
				shell.run("delete /winnt/*")
				shell.run("delete /winnt")
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

settingsApp()
]]
 
local explorerlua = [[
local kernel32 = dofile("/winnt/kernel32.dll")
local kernel32 = dofile("/winnt/gdi32.dll")
local version = kernel32_returnVersion()

local function centerText(text)
	local x, y = term.getCursorPos()
	local w, h = term.getSize()
	term.setCursorPos(math.floor((w - #text) / 2) + 1, y)
	term.write(text)
end

local function WExplorer()
	local currentFolder = "/"
	local w,h = term.getSize()
	local files

	function main()
		redraw()
		listenClicks()
	end

	function redraw()
		makeWindow("WExplorer")
		term.setBackgroundColor(colors.black)
		paintutils.drawLine(1,1,w,1,colors.gray)
		term.setCursorPos(2,1)
		term.setTextColor(colors.white)
		print("<")
		term.setTextColor(colors.black)
		local i = 4
		while i <= 18 do
			paintutils.drawLine(1,i,w,i,colors.white)
			i = i + 1
			term.setBackgroundColor(colors.black)
			term.setCursorPos(1,19)
		end
		-- term.setTextColor(colors.black)
		drawFiles()
	end

	function drawFiles()
		files = nil
		term.setBackgroundColor(colors.white)
		term.setTextColor(colors.black)
		term.setCursorPos(1,3)
		files = fs.list(currentFolder)
		local i = 2
		for _, file in ipairs(files) do
			if i <= 18 then
				term.setCursorPos(1,i)
				print(file)
			end
			i = i + 1
		end
	end

	function listenClicks()
		while true do
			local event, button, X, Y = os.pullEvent("mouse_click")
		
			if button == 1 then
			if X >= 1 and X <= w and Y >= 3 and Y <= 17 then
				if Y == 3 then
					fileHandler(button, files[1])
				elseif Y == 4 then
					fileHandler(button, files[2])
				elseif Y == 5 then
					fileHandler(button, files[3])
				elseif Y == 6 then
					fileHandler(button, files[4])
				elseif Y == 7 then
					fileHandler(button, files[5])
				elseif Y == 8 then
					fileHandler(button, files[6])
				elseif Y == 9 then
					fileHandler(button, files[7])
				elseif Y == 10 then
					fileHandler(button, files[8])
				elseif Y == 11 then
					fileHandler(button, files[9])
				elseif Y == 12 then
					fileHandler(button, files[10])
				elseif Y == 13 then
					fileHandler(button, files[11])
				elseif Y == 14 then
					fileHandler(button, files[12])
				elseif Y == 15 then
					fileHandler(button, files[13])
				elseif Y == 16 then
					fileHandler(button, files[14])
				end
			elseif X == 4 and Y == 3 then
				if currentFolder == "/" or currentFolder == "" then
					listenClicks()
				else
					local parentDirectory = fs.getDir(currentFolder)
					currentFolder = parentDirectory
					redraw()
					drawFiles()
					listenClicks()
				end
			elseif X == 51 and Y == 1 then
				term.setTextColor(colors.white)
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

	function fileHandler(button, file)
		if button == 1 then
			if file == nil then
				return
			end
			
			if fs.isDir(currentFolder.."/"..file) then
				currentFolder = currentFolder.."/"..file
				redraw()
				drawFiles()
				listenClicks()
			else
				shell.run("edit",currentFolder.."/"..file)
				redraw()
				drawFiles()
				listenClicks()
			end
		elseif button == 2 then
			fileContextMenu(file)
		end
	end

	function fileContextMenu(file)
		print("It works!")
		print(currentFolder)
	end

	main()

end

local function desktop()
	local function redraw()
		shell.run("clear")
		local bg = paintutils.loadImage("winnt/bg")
		paintutils.drawImage(bg, 1, 1)
		
		term.setCursorPos(1,19)
		term.setBackgroundColor(colors.white)
		write(" ")
		term.setBackgroundColor(colors.gray)
		write("                                                  ")
	end
	redraw()
	while true do
		local event, button, X, Y = os.pullEvent("mouse_click")
		local XY = X..","..Y
		if X == 1 and Y == 19 then
			term.setCursorPos(1,12)
			term.setBackgroundColor(colors.gray)
			
			print("--------------")
			term.setBackgroundColor(colors.lightGray)
			print("Informationen ")
			print("Programme    >")
			print("Ausführen     ")
			print("Abmelden      ")
			print("Beenden       ")
			term.setBackgroundColor(colors.gray)
			print("--------------")
			
			while true do
				local event, button, X, Y = os.pullEvent("mouse_click")
				
				if X >= 1 and X <= 14 and Y == 13 then
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
				elseif X >= 1 and X <= 14 and Y == 14 then
					term.setCursorPos(15,10)
					print("-------------------")
					term.setBackgroundColor(colors.lightGray)
					term.setCursorPos(15,11)
					print("Explorer           ")
					term.setCursorPos(15,12)
					print("Erweiterungen      ")
					term.setCursorPos(15,13)
					print("Eingabeaufforderung")
					term.setCursorPos(15,14)
					print("Internet Explorer  ")
					term.setCursorPos(15,15)
					print("Alle Programme >>> ")
					term.setCursorPos(15,16)
					term.setBackgroundColor(colors.gray)
					print("-------------------")
					while true do
						local event, button, X, Y = os.pullEvent("mouse_click")
						
						if X >= 15 and X <= 33 and Y == 11 then
							WExplorer()
							term.redirect(term.native())
							redraw()
							break
						elseif X >= 15 and X <= 33 and Y == 12 then
							shell.run("/winnt/extensions.lua")
							term.redirect(term.native())
							redraw()
							break
						elseif X >= 15 and X <= 33 and Y == 13 then
							makeWindow("Eingabeaufforderung")
							term.setBackgroundColor(colors.black)
							term.setTextColor(colors.white)
							shell.run("clear")
							shell.run("shell")
							term.redirect(term.native())
							redraw()
							break
							-- print("Windows wird jetzt neu gestartet.")
							-- sleep(1)
							-- os.reboot()
						elseif X >= 15 and X <= 33 and Y == 14 then
							shell.run("/winnt/iexplore")
							redraw()
							break
						elseif X >= 15 and X <= 33 and Y == 15 then
							shell.run("/winnt/programs")
							term.redirect(term.native())
							redraw()
							break
						elseif X == 1 and Y == 19 then
							desktop()
							break
						end
					end
				elseif X == 1 and Y == 19 then
					desktop()
					break
				elseif X >= 1 and X <= 14 and Y == 15 then
					redraw()
					local renameW = window.create(term.current(),14,7,25,3)
					term.redirect(renameW)
					print("Programmname eingeben")
					term.setCursorPos(2,2)
					local progName = read()
					if fs.exists(progName) then
					elseif progName == "" then
						term.redirect(term.native())
						redraw()
						local renameW2 = window.create(term.current(),14,11,25,7)
						term.redirect(renameW2)
						print("Sie haben einen leeren Programmnamen eingegeben.")
						sleep(2)
						term.redirect(term.native())
						desktop()
					elseif not fs.exists(progName) then
						term.redirect(term.native())
						redraw()
						term.setCursorPos(14, 6)
						term.setBackgroundColor(colors.gray)
						print("Fehler                   ")
						local renameW2 = window.create(term.current(),14,7,25,7)
						term.redirect(renameW2)
						write(progName)
						print(" konnte nicht gefunden werden. Stellen Sie sicher, dass Sie den Namen richtig eingegeben haben.")
						sleep(2)
						term.redirect(term.native())
						desktop()
					end
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
							-- print("Windows wird jetzt neu gestartet.")
							-- sleep(1)
							-- os.reboot()
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

desktop()
]]
 
local extensionslua = [[
local kernel32 = dofile("/winnt/kernel32.dll")
local kernel32 = dofile("/winnt/gdi32.dll")

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
			if fs.exists("/npaintpro") then
				term.redirect(term.native())
				shell.run("/npaintpro")
				redraw()
			else
				print("NPaintPro wird heruntergeladen...")
				local response = http.get("https://pastebin.com/raw/pzWSRqNF")
				
				if response then
					print("Download erfolgreich!")
					print()
					print("Die Datei kann von dieser Anwendung aus gestartet werden!")
					local sResponse = response.readAll()
					response.close()
					local datei = fs.open("/npaintpro", "w")
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

downloaderApp()
]]
 
local gdi32lua = [[
function centerText(text)
	local x, y = term.getCursorPos()
	local w, h = term.getSize()
	term.setCursorPos(math.floor((w - #text) / 2) + 1, y)
	term.write(text)
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

function makeWindow(title)
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
]]
 
local iexplorelua = [[
local x,y = term.getSize()
if peripheral.getType("top") == "modem" then
	rednet.open("top")
elseif peripheral.getType("bottom") == "modem" then
	rednet.open("bottom")
elseif peripheral.getType("left") == "modem" then
	rednet.open("left")
elseif peripheral.getType("right") == "modem" then
	rednet.open("right")
elseif peripheral.getType("back") == "modem" then
	rednet.open("back")
end

local website = "about:home"

function getTitle()
	if website == "about:home" then
		return "Startseite".." - Browser"
	end
	return website.." - Browser"
end

function redraw()
	term.setTextColor(colors.white)
	shell.run("clear")
	paintutils.drawLine(1,1,x,1, colors.gray)
	term.setCursorPos(1,1)
	print(getTitle())
	term.setBackgroundColor(colors.black)
	paintutils.drawLine(1,2,x,2, colors.gray)
	term.setBackgroundColor(colors.black)
	paintutils.drawLine(1,3,x,3, colors.gray)
	term.setBackgroundColor(colors.black)
	paintutils.drawLine(1,4,x,4, colors.gray)
	term.setBackgroundColor(colors.black)
	paintutils.drawLine(2,3,x-1,3, colors.white)
	term.setCursorPos(2,3)
	term.setTextColor(colors.black)
	print(website)
	term.setBackgroundColor(colors.gray)
	term.setTextColor(colors.white)
	term.setCursorPos(x,1)
	print("X")
	term.setTextColor(colors.white)
	term.setBackgroundColor(colors.black)
end

function createWebsite(siteName)
	fs.delete("startup")
	startup = fs.open("startup", "w")
	local servercode = YY
local websiteName = os.getComputerLabel()

if peripheral.getType("top") == "modem" then
	rednet.open("top")
elseif peripheral.getType("bottom") == "modem" then
	rednet.open("bottom")
elseif peripheral.getType("left") == "modem" then
	rednet.open("left")
elseif peripheral.getType("right") == "modem" then
	rednet.open("right")
elseif peripheral.getType("back") == "modem" then
	rednet.open("back")
end

local website = fs.open("index.cchtm","r")
local websiteContent = website:readAll()
website.close()

print("Server gestartet.")

while true do
	id, message = rednet.receive()
	
	if message == websiteName then
		print("Computer mit ID "..id.." hat Websiteaufrufanfrage gestellt")
		rednet.send(id, websiteContent)
	end
end
	ZZ
	startup.writeLine(servercode)
	startup.close()
	os.setComputerLabel(siteName)
	os.reboot()
end

loadWebpage = function()
	local webPageWindow = window.create(term.current(), 1, 5, 51, 17)
	local oldTerm = term.redirect(webPageWindow)
	if website == "about:home" then
		print("Wilkommen! Für dieses Programm brauchst du ein Modem auf irgendeiner Seite.")
		print()
		print("Um eine Website zu hosten: about:server")
	elseif website == "about:server" then
		print("Wenn du einen Server einrichten willst, lade das Programm")
		print("auf einen anderen Computer herunter und tippe die URL ein.")
		print("Verwenden Sie diese Option nicht auf den aktuellen Computer, ")
		print("da du dann ihn zu einem Server machst.")
		print()
		write(" ")
		term.setBackgroundColor(colors.lightGray)
		write(" Fortsetzen ")
		term.setBackgroundColor(colors.black)
		write(" ")
		term.setBackgroundColor(colors.lightGray)
		write(" Abbrechen ")
		term.setBackgroundColor(colors.black)
	else
		rednet.broadcast(website)
		print("Verbinde...")
		id, message = rednet.receive(0.1)
		if message == nil then
			print("404 Error: Website nicht verfügbar")
		else
			fs.makeDir(".cache")
			local cacheFile = fs.open(".cache/"..website, "w")
			cacheFile.writeLine(message)
			cacheFile.close()
			shell.run(".cache/"..website)
		end
	end
	
	while true do
		local event, button, X, Y = os.pullEvent("mouse_click")
		
		if X == x and Y == 1 then
			term.clear()
			term.setCursorPos(1,1)
			term.redirect(oldTerm)
			term.setBackgroundColor(colors.black)
			term.setTextColor(colors.white)
			term.clear()
			term.setCursorPos(1,1)
			break
		elseif X >= 2 and X <= x-1 and Y == 3 then
			term.redirect(oldTerm)
			paintutils.drawLine(2,3,x-1,3, colors.white)
			term.setCursorPos(2,3)
			local oldBgColor = term.getBackgroundColor()
			local oldTxtColor = term.getTextColor()
			term.setBackgroundColor(colors.white)
			term.setTextColor(colors.black)
			local page2Open = read()
			term.setBackgroundColor(oldBgColor)
			term.setTextColor(oldTxtColor)
			webPageWindow.setBackgroundColor(colors.black)
			webPageWindow.clear()
			webPageWindow.setCursorPos(1,1)
			redirect(page2Open)
			break
		elseif website == "about:server" then
			if X >= 2 and X <= 13 then
				webPageWindow.setBackgroundColor(colors.black)
				webPageWindow.clear()
				webPageWindow.setCursorPos(1,1)
				print("Bitte geben Sie den Namen der Website an.")
				print()
				paintutils.drawLine(2,3,x-1,3, colors.white)
				term.setCursorPos(2,3)
				term.setTextColor(colors.black)
				local webSiteName = read()
				term.setTextColor(colors.white)
				rednet.broadcast(webSiteName)
				i, me = rednet.receive(0.001)
				if me == nil then
					if fs.exists("/index.cchtm") == false then
						webPageWindow.setBackgroundColor(colors.black)
						webPageWindow.clear()
						webPageWindow.setCursorPos(1,1)
						print("Bitte erstelle die Website zuerst!")
						sleep(0.5)
						local websitefile = fs.open("/index.cchtm", "w")
						websitefile.writeLine("local title = \"\" -- Titel der Website, der im Browser erscheinen wird")
						websitefile.flush()
						websitefile.close()
						term.redirect(oldTerm)
						shell.run("edit", "/index.cchtm")
						createWebsite(webSiteName)
					end
				else
					webPageWindow.setBackgroundColor(colors.black)
					webPageWindow.clear()
					webPageWindow.setCursorPos(1,1)
					print("Diese Website ist bereits vergeben.")
				end
			elseif X >= 15 and X <= 25 then
				
			end
		end
	end
end

function redirect(url)
	website = url
	redraw()
	loadWebpage()
end

redraw()
loadWebpage()
]]
 
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
 
local logonuilua = [[
local gdi32 = dofile("/winnt/gdi32.dll")
local whiletrue = true

local function login()
	if fs.exists("/winnt/login.nfp") then
		local image = paintutils.loadImage("/winnt/login.nfp")
		paintutils.drawImage(image, 1, 1)
	else
		term.setBackgroundColor(colors.blue)
		shell.run("clear")
	end
	local w, h = term.getSize()
	term.setBackgroundColor(colors.white)
	term.setCursorPos(1,6)
	local usersFiles = fs.list("/winnt/users")
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
	
	term.setCursorPos(1,19)
	term.setBackgroundColor(colors.white)
	term.setTextColor(colors.black)
	write("Herunterfahren                                      ")
	
	term.setBackgroundColor(colors.gray)
	term.setTextColor(colors.black)
	for file, _ in ipairs(usersFiles) do
		term.setCursorPos(17,y)
		term.setTextColor(colors.white)
		print(_)
		y = y + 1
	end
	term.setCursorPos(1,4)
	term.setBackgroundColor(colors.white)
	term.setTextColor(colors.black)
	centerText(" Benutzer auswählen ")
	term.setCursorPos(1,10)
	term.setBackgroundColor(colors.lightGray)
	centerText("            ")
	while whiletrue do
		local event, button, X, Y = os.pullEvent("mouse_click");
		
		if X >= 17 and X <= 34 and Y == 6 then
			passwordLogin(usersFiles[1])
		elseif X >= 17 and X <= 34 and Y == 7 then
			passwordLogin(usersFiles[2])
		elseif X >= 17 and X <= 34 and Y == 8 then
			passwordLogin(usersFiles[3])
		end
	end
end

function passwordLogin(username)
	if username == nil then
	else
	local w, h = term.getSize()
	local usersT = fs.open("/winnt/users/"..username, "r")
	local rPassword = usersT.readAll()
	usersT.close()
	if rPassword == "" then
		term.setBackgroundColor(colors.blue)
		shell.run("clear")
		
		term.setCursorPos(1,10)
		term.setTextColour(colors.white)
		centerText("Willkommen, "..username.."!")
		whiletrue = false
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
		whiletrue = false
		return
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
				--os.reboot()
				login()
				break
			end
		end
	end
	end
end

login()
sleep(2)
shell.run("/winnt/explorer.lua")
]]
 
local ntoskrnllua = [[
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

local main = function()
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
	
	term.setBackgroundColor(colors.white)
	term.setCursorPos(14,18)
	print("                   ")
	
	term.setBackgroundColor(colors.green)
	term.setCursorPos(14,18)
	textutils.slowPrint("                   ")
	term.setBackgroundColor(colors.white)
	term.setCursorPos(14,18)
	textutils.slowPrint("                   ")
	term.setBackgroundColor(colors.green)
	term.setCursorPos(14,18)
	textutils.slowPrint("                   ")
	term.setBackgroundColor(colors.white)
	term.setCursorPos(14,18)
	textutils.slowPrint("                   ")
	term.setBackgroundColor(colors.green)
	term.setCursorPos(14,18)
	textutils.slowPrint("                   ")
	shell.run("/winnt/logonui.lua")
end

main()
]]
 
local programslua = [[
local kernel32 = dofile("/winnt/kernel32.dll")
local kernel32 = dofile("/winnt/gdi32.dll")
local kernel32 = dofile("/winnt/installedPrograms.db")
local w,h = term.getSize()
local files

local function main()
	local function redraw()
		makeWindow("Programme")
		print("Installiere Programme durchsuchen und starten")
		drawPrograms()
		listenClicks()
	end
	redraw()
end

function drawPrograms()
	files = nil
    term.setBackgroundColor(colors.white)
    term.setTextColor(colors.black)
    term.setCursorPos(1,3)
    local i = 3
	files = installedPrograms
    for _, file in ipairs(installedPrograms) do
		if i <= 15 then
			term.setCursorPos(1,i)
			local displayName, pathToLauncher = file:match("([^:]+):([^:]+)")
			print(displayName)
		end
        i = i + 1
    end
end

function listenClicks()
    while true do
        local event, button, X, Y = os.pullEvent("mouse_click")
    
		if X >= 1 and X <= w and Y >= 4 and Y <= 17 then
			if Y == 4 then
				fileHandler(button, files[1])
			elseif Y == 5 then
				fileHandler(button, files[2])
			elseif Y == 6 then
				fileHandler(button, files[3])
			elseif Y == 7 then
				fileHandler(button, files[4])
			elseif Y == 8 then
				fileHandler(button, files[5])
			elseif Y == 9 then
				fileHandler(button, files[6])
			elseif Y == 10 then
				fileHandler(button, files[7])
			elseif Y == 11 then
				fileHandler(button, files[8])
			elseif Y == 12 then
				fileHandler(button, files[9])
			elseif Y == 13 then
				fileHandler(button, files[10])
			elseif Y == 14 then
				fileHandler(button, files[11])
			elseif Y == 15 then
				fileHandler(button, files[12])
			elseif Y == 16 then
				fileHandler(button, files[13])
			elseif Y == 17 then
				fileHandler(button, files[14])
			end
		elseif X == 51 and Y == 1 then
			term.setTextColor(colors.white)
			break
		end
    end
end

function fileHandler(button, file)
	if button == 1 then
		if file == nil then
			return
		end
		
		local displayName, pathToLauncher = file:match("([^:]+):([^:]+)")
		shell.run(pathToLauncher)
		error()
	end
end

main()
]]
 
local kernel32lua = [[
function kernel32_returnVersion()
	return "5.0"
end
]]
 
local installedprogramslua = [[
installedPrograms = {}

]]
 
local function main()
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
drawPictureTable(background, 1, 1, colors.white)

term.setCursorPos(2,2)
term.setBackgroundColor(colors.gray)
print("Windows installieren                  ")
term.setBackgroundColor(colors.white)
term.setCursorPos(2,3)
term.setTextColor(colors.black)
print(" Vielen Dank, dass Sie für Windows OS ")
term.setCursorPos(2,4)
print(" 5.0 Beta entschieden haben.          ")
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
	
	local bootFile = [[
		shell.run("/winnt/ntoskrnl.lua")
	]]
	
	if fs.exists("/startup") then
		fs.delete("/startup")
		startupFile = fs.open("/startup", "w")
		startupFile.writeLine(bootFile)
		startupFile.flush()
		startupFile.close()
	else
		startupFile = fs.open("/startup", "w")
		startupFile.writeLine(bootFile)
		startupFile.flush()
		startupFile.close()
	end
	
	startupDisk = fs.open("/winnt/startupDisk", "w")
	startupDisk.writeLine(startupDiskFile)
	
	startupDisk.flush()
	startupDisk.close()
	
	
	bg = fs.open("/winnt/bg","w")
	
	for index, value in pairs(background) do
		bg.writeLine(value)
	end
	 
	bg.flush()
	bg.close()
	
	bg = fs.open("/winnt/login.nfp","w")
	
	for index, value in pairs(background) do
		bg.writeLine(value)
	end
	 
	bg.flush()
	bg.close()
	
	controlfile = fs.open("/winnt/control.lua","w")
	controlfile.writeLine(controllua)
	controlfile.flush()
	controlfile.close()
	
	controlfile = fs.open("/winnt/explorer.lua","w")
	controlfile.writeLine(explorerlua)
	controlfile.flush()
	controlfile.close()
	
	controlfile = fs.open("/winnt/extensions.lua","w")
	controlfile.writeLine(extensionslua)
	controlfile.flush()
	controlfile.close()
	
	controlfile = fs.open("/winnt/gdi32.dll","w")
	controlfile.writeLine(gdi32lua)
	controlfile.flush()
	controlfile.close()
	
	controlfile = fs.open("/winnt/iexplore.lua","w")
	iexplorelua = iexplorelua:gsub("YY","%[%[")
	iexplorelua = iexplorelua:gsub("ZZ","%]%]")
	controlfile.writeLine(iexplorelua)
	controlfile.flush()
	controlfile.close()
	
	controlfile = fs.open("/winnt/logonui.lua","w")
	controlfile.writeLine(logonuilua)
	controlfile.flush()
	controlfile.close()
	
	controlfile = fs.open("/winnt/ntoskrnl.lua","w")
	controlfile.writeLine(ntoskrnllua)
	controlfile.flush()
	controlfile.close()
	
	controlfile = fs.open("/winnt/programs.lua","w")
	controlfile.writeLine(programslua)
	controlfile.flush()
	controlfile.close()
	
	controlfile = fs.open("/winnt/kernel32.dll","w")
	controlfile.writeLine(kernel32lua)
	controlfile.flush()
	controlfile.close()
	
	controlfile = fs.open("/winnt/installedPrograms.db","w")
	controlfile.writeLine(installedprogramslua)
	controlfile.flush()
	controlfile.close()
	
	shell.run("mkdir /winnt/programs")
	shell.run("mkdir /winnt/users")
 
	user = fs.open("/winnt/users/"..username, "w")
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
end
	
main()

