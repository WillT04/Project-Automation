# Make sure to read README to understand how to use this script

function New-Project {
	# Variables to change
	$username = "username"
	$password = "password"
	$projectpath = "Path/To/Projects"
	# End of variables to change

	

	# Makes credentials for authentication
	$credentials = "${username}:$password"
	$encodedCredentials = [System.Convert]::ToBase64String([System.Text.Encoding]::ASCII.GetBytes($credentials))

	# Asks the users for the variables
	[String] $name = Read-Host "Name of project"
	[String] $tags = Read-Host "Tags"
	[String] $tracked = Read-Host "Tracked (Y/N)"
	Write-Host ""

	# Goes to the Projects folder
	Set-Location $projectpath 

	# If you want the project to be tracked on bitbucket
	if ($tracked.ToUpper().Equals("Y")) {
		Set-Location Tracked

		mkdir $name | Out-Null
		Set-Location $name

		# Initiates git
		git init | Out-Null

		# Gets the repo slug (lower case and no spaces)
		$slugs = $name.ToLower() -split " "
		$slug = $slugs -join "-"

		# JSON Body of request
		$body = @"
		{
			"scm": "git",
			"project": {
				"key": "CD"
			},
			"is_private": true,
			"name": "$name",
			"fork_policy": "no_public_forks"
		}
"@

		# Send the POST request to the Bitbucket api
		Invoke-WebRequest -UseBasicParsing "https://api.bitbucket.org/2.0/repositories/$username/$slug" -ContentType "application/json" -Method POST -Headers @{ Authorization = "Basic $encodedCredentials" } -Body $body | Out-Null

		# Adds the remote
		git remote add origin git@bitbucket.org:$username/$slug.git

		# Adds the basic repo files (and ignores desktop.ini)
		New-Item -path "README.md" -ItemType File | Out-Null
		Set-Content ".gitignore" -Value "desktop.ini" 

		# Adds all files to bitbucket and sets the origin master as the defualt branch
		git add .
		git commit -m "Initial Commit" | Out-Null
		git push -u origin master 2>&1 | Out-Null

	} else {
		Set-Location Untracked		

		mkdir $name | Out-Null
		Set-Location $name 
	}

	# Sets up the tags so it groups correctly in the file explorer
	[String[]] $newtags = $tags -split ","
	[String] $realtags = $newtags -join ";"

	# Adds the tag
	Set-Content "desktop.ini" -Value "[{F29F85E0-4FF9-1068-AB91-08002B27B3D9}]
Prop5=31,$realtags"

	attrib +h +s desktop.ini
}

Set-Alias -Name create -Value New-Project
Set-Alias -Name c -Value New-Project
