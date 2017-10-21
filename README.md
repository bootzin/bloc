## Locating your files has never been faster!

**bloc** is a **b**etter **loc**ate which is capable of quickly finding any file/archive you have stored in your computer with as much flexibility as needed. The speed increase may be of up to 10 times faster compared to normal locate, and up to 30 times compared to find.

### How it works
`bloc`works pretty much in the same way that locate does: it is a cli searching tool that creates a database where it looks for the specified file or directory and outputs it to STDOUT. The 2 major differences here are that:

* 1: `bloc` does not compress the database.  
whereas this means that the database file is larger, it also means that it doesn't have to waste time decompressing the database before searching for certain query. Moreover, most tests reported that locate can only decrease database size to about a third of the original's, which, nowadays, isn't that much of a problem for most computers.
    
* 2: `bloc` uses [rg](https://github.com/BurntSushi/ripgrep) to search for it's files, which provides a much faster result than most other search tools.
    
### Prerequisites
* [rg](https://github.com/BurntSushi/ripgrep) (Optional if you change the default search in the bloc file)

### Installation

***Warning:*** bloc-populate is the file responsible for creating and updating the database, but in order to map every accessible directory it has to have root priveleges (setUID). If you do no want it have these privileges, you can still run `bloc`, except it won't search files you can't normally access.

As this is the first release of `bloc` no official installation is provided, but here is what you need to do if you want to run `bloc` in your computer:

**1.** Clone this repo to your local machine
    
    git clone https://github.com/bootzin/bloc

**2.** Edit both bloc and bloc-populate files with your editor of choice and change both database and OUTPUT default values so that they match the location of the database in your computer
    
    database=/home/user/path/to/bloc.db
   
**3.** Make both `bloc` and `bloc-populate` executables with the following commands:

    sudo chmod +x /path/to/bloc
    sudo chmod +x /path/to/bloc-populate
   
**4.** [Optional] Grant root privileges to `bloc-populate` using the following commands:

    sudo chown root.root path/to/bloc-populate
    sudo chmod 4755 /path/to/bloc-populate
    

**5.** Run `bloc-populate` or `bloc --populate` in order to create the initial database
    bloc --populate
    
**6.** [Optional] Add on your autostart script an execution command to populate bloc database, so that when you start the system it gets automatically updated

### Usage

    Usage: bloc [OPTIONS] FILE
    Searches system for a file or directory
        -h, --help 		displays this help message and exits.
        -c <database>	specifies where to load the database from
        -s <searcher>	specifies searcher to be used. Defaults to ripgrep. Additional commands may be used within '' i.e. 'grep -v'
        -v 			verbose
        --populate <output>	populate bloc database and saves it to <output>. Default saves to ~/Software/bloc.db

### Tips

* You can use any searcher you want with bloc (grep, ag, ack ...), as long as you pass it as an argument using the `-s` tag or change the default searcher command on bloc file
* If you want to add any arguments to the searcher (i.e. -v, -E, -N) you can do so by specifing them with the `-s` tag, they should all work just right!
* You can populate `bloc` database by running `bloc -p` instead of `bloc-populate`
* bloc-populate can recieve an output file as an argument when used with the `-o` tag

### License

This Project is Lincensed under the MIT License

#### Disclaimer
This is a WIP, I intend to implement more functionalities to `bloc` to make it even better. For now, if you have any ideas you wish to contribute, please feel free to contact me (:
