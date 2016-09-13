# simple-photoshow

Just a simple ruby program that downloads new photos from a Flickr group, plus instructions how to start the actual photo slideshow.

Tested on RasPi3 running Raspbian (Jessie).

### Edit your preferences

Create file *locals.rb* using template *locals-default.rb* as an example.

Go to your flickr preferences to get your API key. Finding your group id can be tricky with Flickr's user interface. One way is to hover your mouse cursor (!) over your buddy icon or *leave group* -button and see what reads in the status bar. It should be something like *0000000@N22*. Add these in your new *locals.rb* file.

### Starting manually

Run the photo show with feh:

*feh -Y -x -q -D 8 -B black -F -Z -z -r ~/Pictures/*

(set -D 8 to other number if you want faster or slower picture changing speed)

### Crontab

(Paths depending where this program is installed)

*crontab -e*, add:
```
@reboot ruby /home/pi/Documents/simple-photoshow/flickr_download.rb
0 * * * * ruby /home/pi/Documents/simple-photoshow/flickr_download.rb
*/3 * * * * /bin/bash /home/pi/Documents/simple-photoshow/launch_photoshow.sh
```
make the script executable:
*chmod a+x launch_photoshow.sh*

.sh file checks if a feh process is running - if not, then it launches a new one within 3 mins.

Ruby script now launched on every startup and every hour.

### Energy saver settings

(using Raspbian)

edit your */etc/lightdm/lightdm.conf*

in *[SeatDefaults]* add:

*xserver-command=X -s 0 -dpms*

restart your RasPi

(check your new preferences with *xset -q*)
