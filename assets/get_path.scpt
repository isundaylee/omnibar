tell application "iTunes"
  try
    set tra to current track
    try
      set loc to (location of tra)
      do shell script "echo " & (quoted form of (POSIX path of (loc)))
    end try
  end try
end tell