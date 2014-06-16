set resultText to ""
set currentLine to ""
set numPhones to 0

tell application "Contacts"
	-- Find the maximum number of phone numbers
	repeat with x from 1 to the count of people
		set thePerson to person x
		set countP to count of phone of thePerson
		if countP > numPhones then
			set numPhones to countP
		end if
	end repeat
	
	-- Export all contacts
	repeat with x from 1 to the count of people
		set thePerson to person x
		set my currentLine to ""
		
		set my currentLine to my currentLine & "\"" & the name of thePerson & "###phoneLabelHere###\","
		set my currentLine to my currentLine & "\"###phoneHere###\""
		
		-- Walk through Phone entries
		set numCurrentPhones to the count of phone of thePerson
		repeat with thePhone in the phone of thePerson
			set thePhoneValue to the value of thePhone
			set thePhoneLabel to the label of thePhone
			set theLine to my searchReplace(my currentLine, "###phoneHere###", thePhoneValue)
			if numCurrentPhones > 1 then
				set theLine to my searchReplace(theLine, "###phoneLabelHere###", " (" & thePhoneLabel & ")")
			else
				set theLine to my searchReplace(theLine, "###phoneLabelHere###", "")
			end if
			set my resultText to my resultText & theLine & linefeed
		end repeat
		
	end repeat
	
	-- Save file
	set theFile to choose file name with prompt "Save as:" default name "snom.csv" default location the path to home folder
	set fp to open for access theFile with write permission
	write resultText to fp as Çclass utf8È
	close access fp
	
end tell

on searchReplace(origStr, searchStr, replaceStr)
	set old_delim to AppleScript's text item delimiters
	set AppleScript's text item delimiters to searchStr
	set origStr to text items of origStr
	set AppleScript's text item delimiters to replaceStr
	set origStr to origStr as string
	set AppleScript's text item delimiters to old_delim
	return origStr
end searchReplace
