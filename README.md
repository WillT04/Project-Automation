# Info
This project allows for quick setup of new projects. It creates the project folder and tags it. It also allows for automatically adding the project to github, and adding the required files for git (README.md and .gitignore). It also allows you to add github repos to a personal or company account.

# Setup
* Install the GitHub CLI
* Run "gh auth login" in a PowerShell console
* Add the "create.ps1" script to your PowerShell profile (run "code $profile" to access PowerShell profile)


# Usage
1. Run "New-Project" from PowerShell
2. Enter the name of the project
3. Enter the tags, seperated by a comma
4. Enter if you want the folder to be tracked on git (Y/N)
4.1. If the project is tracked, you will need to enter some extra details


# Tags
### How to tag manually
1. Put the "Tag_Folder.bat" file in D://Program Files (x86)/Tag Folder
2. Run the "Tag Folder Registry.reg" to add the ability to tag folders to the right click context menu

### Info
* If you want to tag folders, you must go into the folder and then right click empty space
* To group folders by tag you need to first add the tag column and then select it in the "Group by" setings (under "View")
* If you place the "Tag_Folder.bat" file somewhere other than where I said above you will need to change the "Tag Folder Registry.reg" file to fit
* Tag feature developed by Pinjoy


# Project Structure
```
Name of Project Folder/  (Defined in "create_repo.py")
├── Tracked
│   ├── Projects
│   ├── That
│   ├── Are
│   ├── Tracked
│   ├── On
│   └── Github
└── Untracked
    ├── Projects
    ├── That
    ├── Are
    └── Local
```


# Aliases
### New-Project:
* create
* c
