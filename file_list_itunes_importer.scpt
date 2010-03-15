property extension_list : {"urls"}


on adding folder items to this_folder after receiving these_items
	try
		repeat with i from 1 to number of items in these_items
			set this_item to item i of these_items
			set the item_info to the info for this_item
			if (the name extension of the item_info is in the extension_list) then
				tell application "Finder"
					set the folder_name to the name of this_item
				end tell
				set the target_folder to the "/tmp/DATA_" & folder_name
				set the source_item to the quoted form of the POSIX path of the this_item
				set cmd to the "/usr/local/bin/wget -P " & target_folder & " -q -i " & source_item
				do shell script cmd
				
				do shell script "rm -r " & target_folder & "/*.m3u"
				
				set folder_alias to POSIX file target_folder
				tell application "iTunes"
					add folder_alias
				end tell
				do shell script "rm -r " & target_folder
				do shell script "rm " & source_item
			end if
		end repeat
	on error error_message number error_number
		if the error_number is not -128 then
			tell application "Finder"
				activate
				display dialog error_message buttons {"Cancel"} default button 1 giving up after 120
			end tell
		end if
	end try
end adding folder items to
