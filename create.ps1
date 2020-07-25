# Make sure to read README to understand how to use this script

# Variables to change

	[String] $projectsPath = "Path/To/Projects"
	[String] $username = "username"
	[String] $accessToken = "token"
	[String] $companyName = "name"

	# End of variables to change

function New-Project {
	$base64Token = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(("{0}:{1}" -f $username, $accessToken)))

	# Asks the users for the variables
	[String] $name = Read-Host "Name of project"
	[String] $tags = Read-Host "Tags"
	[String] $tracked = Read-Host "Tracked (Y/N)"
	

	# Goes to the Projects folder
	Set-Location $projectsPath 

	# If you want the project to be tracked on github
	if ($tracked.ToUpper().Equals("Y")) {
		[String] $org = Read-Host "Personal or Company (P/C)"
		[String] $description = Read-Host "Description (Leave empty for default)"
		[String] $private = Read-Host "Private (Y/N)"
		Write-Host ""

		if ($org.ToUpper().Equals("C")) {
			$org = $companyName
		} else {
			$org = $username
		}

		if ($description.Length -lt 1) {
			$description = "A new repo"
		}

		if ($private.ToUpper().Equals("N")) {
			$private = "false"
		} else {
			$private = "true"
		}

		Set-Location Tracked

		mkdir $name | Out-Null
		Set-Location $name

		# Initiates git
		git init | Out-Null

		# Gets the repo slug (no spaces)
		$slugs = $name -split " "
		$slug = $slugs -join "-"

		# Make the repo
		$headers = @{
			"Authorization" = "Basic $base64Token"
		}

		$body = @{
			name = $slug;
			description = $description;
			org = $org;
			private = $private
		} | ConvertTo-Json

		if ($org.Equals($companyName)) {
			Invoke-RestMethod -Uri https://api.github.com/orgs/$org/repos -Headers $headers -Body $body -Method Post | Out-Null
		} else {
			Invoke-RestMethod -Uri https://api.github.com/user/repos -Headers $headers -Body $body -Method Post | Out-Null
		}
		
		
		# Adds the remote
		git remote add origin git@github.com:$org/$slug.git

		# Adds the basic repo files (and ignores desktop.ini)
		New-Item -path "README.md" -ItemType File | Out-Null
		Set-Content ".gitignore" -Value "desktop.ini" 

		# Adds all files to github and sets the origin master as the defualt branch
		git add .
		git commit -m "Initial Commit" | Out-Null
		git push -u origin master 2>&1 | Out-Null

	} else {
		Write-Host ""
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
