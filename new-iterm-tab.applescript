-- this simple script opens a new iTerm tab and
-- `cd`s into the path that's held in the clipboard

on run (arguments)
	set thePath to (the clipboard)
	set the clipboard to ""
	makeTabAtPath(thePath)
end run

on makeTabAtPath(path)
	set command to "cd " & escapeSpaces(path)
	tell application "iTerm"
		activate
		-- send a ⌘-T keystroke to iTerm
		-- this is an easier way to make a new tab than the "real" AppleScript way
		tell application "System Events" to keystroke "t" using command down
		-- run the command
		tell current session of first window
			write text command
		end tell
	end tell
end makeTabAtPath

on escapeSpaces(_string)
	-- insert backslashes in front of all spaces
	set _string to (do shell script "echo \"" & _string & "\" | sed 's/ /\\\\ /g'")
	-- the string that was passed in already contained backslash-escaped spaces,
	-- you'll now have double backslashes
	-- sed does not support lookbehind, so replace double backslashes with single backslashes
	set _string to (do shell script "echo \"" & _string & "\" | sed 's/(\\\\)+/\\\\/g'")
	return _string
end escapeSpaces
