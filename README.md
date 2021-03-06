## Locating your files has never been faster!

**bloc** is a **b**etter **loc**ate which is capable of quickly finding any file/archive you have stored in your computer with as much flexibility as needed. The speed increase may be of up to 10 times faster compared to normal locate, and up to 30 times compared to find. (Pictures will be available in a future release)

### How it works
`bloc`works pretty much in the same way that locate does: it is a cli searching tool that creates a database where it looks for the specified file or directory and outputs its name/location to STDOUT. The 2 major differences here are that:

* 1: `bloc` does not compress the database.  
whereas this means that the database file is larger, it also means that it doesn't have to waste time decompressing the database before searching for certain query. Moreover, most tests reported that locate can only decrease database size to about a third of the original's, which, nowadays, isn't that much of a problem for most computers.
    
* 2: `bloc` uses [rg](https://github.com/BurntSushi/ripgrep) to search for it's files, which provides a much faster result than most other search tools.
    
### Prerequisites
* [rg](https://github.com/BurntSushi/ripgrep) (Optional if you change the default searching tool in the bloc file)

### Installation

Installation of `bloc` can be made by running the install script provided, it needs two arguments, or it won't work. The first is the install directory. As of now, the script will create a symbolic link into that specified install folder, and add that folder to $PATH, a later release will allow you to choose whether to have it symlinked or hard copied. The second argument is the place where you want to store the database, and where the database will be stored by default on future updates. Please keep in mind that neither of these values have a default yet, it shall be added soon though.

The other option that you have is to follow below instructions, in case you have any problems with the installation script.

**1.** Clone this repo to your local machine
    
    git clone https://github.com/bootzin/bloc

**2** Add `bloc` to your local bin folder so that you can execute it from anywhere. I usually keep them on a separate folder and symlink them to ~/bin (which must be in $PATH).

**3** Edit the default path for database file in bloc/bloc-populate. They default to ~/Software/bloc, but make sure that folder exists before running the program.
   
**4.** Run `bloc-populate` or `bloc -p` in order to create the initial database (In a future release `bloc` will automatically do this before it's first run)

    bloc --populate
    
**5.** [Optional] Add on your autostart script an execution command to populate bloc database, so that when you start the system it gets automatically updated

### Usage

    Usage: bloc [OPTIONS] FILE
    Searches system for a file or directory
        -h, --help 		displays this help message and exits.
        -c <database>		specifies where to load the database from
        -s <searcher>		specifies searcher to be used. Defaults to ripgrep. Additional commands may be used within '' i.e. 'grep -v'
        -v, --verbose		verbose
        -v2, -vv		Second verbosity level, more information is shown
        -p, --populate <output>	populate bloc database and saves it to <output>. Default saves to ~/Software/bloc.db

### Autoupdate

As of now there are two main ways of performing automatic updates of `bloc`. The first one is to use [cron](https://en.wikipedia.org/wiki/Cron) to schedule regular interval updates by adding

    */5 * * * bloc -p

in your cronstab file, which will perform the update every 5 minutes. The other one is by using a useful program created by z3bra called [wendy](https://github.com/z3bra/wendy). What this program does is it checks for changes under certain directory and executes a command if any changes are detected. The command you'd use in this case would be 

    wendy -f /home/user/ -t 300 bloc -p

which would check at every 5 minutes if there's been a change in your $HOME dir and if there is, it would perform an update. This would work because every time you run a shell command it gets registered under your history file (.bash-history, .zsh-history, etc), and wendy would detect that change. If your shell doesn't have a history then you have to stick with the first method.

### Tips

* By default `bloc` does not detect files/directories you do not normally have access to. To change this, simply run `bloc -p` as sudo, and it will detect /root/ files as well 
* You can use any searching toll you want with bloc (grep, ag, ack ...), as long as you pass it as an argument using the `-s` tag or change the default searcher command in the bloc file
* If you want to add any arguments to the searcher (i.e. -v, -E, -N) you can do so by specifing them with the `-s` tag, they should all work just right! (Remember to also add the searcher you're using, i.e 'rg -vE')
* You can populate `bloc` database by running `bloc -p` instead of `bloc-populate`
* bloc-populate can recieve an output file as an argument when used with the `-o` tag
* You can use the `-c` tag on `bloc` to make it search for inside file, not just its database

### Troubleshooting

If you're getting /root/path/to/db instead of /home/user/path/to/db in when running `bloc-populate` as sudo make sure you have the following line in your sudoers file:

	Default env_keep += "HOME"

Besides that, leave me an Issue reporting the steps necessary to reproduce the error you've got and I'll look into it

### License

This Project is Lincensed under the MIT License

#### Disclaimer
This is a WIP, I intend to implement more functionalities to `bloc` to make it even better. For now, if you have any ideas you wish to contribute, please feel free to contact me (:
