# simple-photoshow

Just a simple ruby program that downloads new photos from a Flickr group plus instructions how to start the actual photo slideshow.

### Starting manually

Run the photo show with feh:

feh -Y -x -q -D 5 -B black -F -Z -z -r ~/Pictures/

### Crontab
(Paths depending where this program is installed)
```
@reboot ruby /home/pi/Documents/simple-photoshow/flickr_download.rb
0 * * * * ruby /home/pi/Documents/simple-photoshow/flickr_download.rb
*/3 * * * * /bin/bash /home/pi/Documents/simple-photoshow/launch_photoshow.sh
```
make script executable
chmod a+x launch_photoshow.sh

.sh file checks if a feh process is running - if not, then it launches a new one

Ruby script now launched on every startup and every hour.
