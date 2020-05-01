# Setup
* Fill in "create.ps1" with your authentication data and path to your projects folder
* Add the "create.ps1" script to your PowerShell profile (run "code $profile" to access PowerShell profile)


# Usage
1. Run "create" from PowerShell
2. Enter the name of the project
3. Enter the tags, seperated by a comma
4. Enter if you want the folder to be tracked on git (Y/N)
5. Enter the IDEs that you want to open with the project


# IDE Options
* IDEA = Intellij IDEA
* PyCharm = PyCharm
* Code = VS Code


# Tags
### How to tag
1. Put the "Tag_Folder.bat" file in D://Program Files (x86)/Tag Folder
2. Run the "Tag Folder Registry.reg" to add the ability to tag folders to the right click context menu

### Info
* If you want to tag folders, you must go into the folder and then right click empty space
* To group folders by tag you need to first add the tag column and then select it in the "Group by" setings (under "View")
* If you place the "Tag_Folder.bat" file somewhere other than where I said above you will need to change the "Tag Folder Registry.reg" file to fit

# Project Structure
```
Name of Project Folder/  (Defined in "create_repo.py")
├── Tracked
│   ├── Projects
│   ├── That
│   ├── Are
│   ├── Tracked
│   ├── On
│   └── Bitbucket
└── Untracked
    ├── Projects
    ├── That
    ├── Are
    └── Local
```