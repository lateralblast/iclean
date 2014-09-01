iClean
======

A ruby script to clean up iTunes files/directories

Introduction
------------

This is a ruby script that can be used to clean up iTunes files/directories.

Features
--------

Current:

- Find and list/remove old versions of Mobile Applications

Planned:

- Check MP3/AAC information and tags to ensure they are correct

License
-------

This software is licensed as CC-BA (Creative Commons By Attrbution)

http://creativecommons.org/licenses/by/4.0/legalcode

Usage
-----

Get usage information:

```
$ iclean.rb -h

Usage: iclean.rb -[adhi:loV]

-h: Print usage information
-V: Print version information
-a: Handle old versions of application
-l: List (used in conjunction with -a)
-o: List old applications (used in conjunction with -a)
-d: Delete old (used in conjunction with -a)
-i: Set iTunes directory
```

Examples
--------

List old files:

```
$ iclean.rb -a -o
Application: 360
Newest:      4.3
Older:       2.5.4
Old file:    /Users/spindler/Music/iTunes/iTunes Media/Mobile Applications/360 2.5.4.ipa
Application: 360
Newest:      4.3
Older:       4.0.5
Old file:    /Users/spindler/Music/iTunes/iTunes Media/Mobile Applications/360 4.0.5.ipa
Application: 3D Wallpapers
Newest:      1.5
Older:       1.4
Old file:    /Users/spindler/Music/iTunes/iTunes Media/Mobile Applications/3D Wallpapers 1.4.ipa
Application: 8player lite
Newest:      2.8.2
Older:       2.2.2
Old file:    /Users/spindler/Music/iTunes/iTunes Media/Mobile Applications/8player lite 2.2.2.ipa
Application: A+
Newest:      1.5
Older:       1.3
Old file:    /Users/spindler/Music/iTunes/iTunes Media/Mobile Applications/A+ 1.3.ipa
Application: Ab Workout
Newest:      3.25
Older:       2.80
Old file:    /Users/spindler/Music/iTunes/iTunes Media/Mobile Applications/Ab Workout 2.80.ipa
Application: Abba Bola
Newest:      2.73
Older:       2.073
Old file:    /Users/spindler/Music/iTunes/iTunes Media/Mobile Applications/Abba Bola 2.073 1.ipa
Application: Abba Bola
Newest:      2.73
Older:       2.073
Old file:    /Users/spindler/Music/iTunes/iTunes Media/Mobile Applications/Abba Bola 2.073.ipa
Application: AccuWeather
Newest:      2.0.1
Older:       1.9.0
```

Delete old files:

```
$ iclean.rb -a -d |more
Application: 360
Newest:      4.3
Older:       2.5.4
Deleting file:    /Users/spindler/Music/iTunes/iTunes Media/Mobile Applications/360 2.5.4.ipa
Application: 360
Newest:      4.3
Older:       4.0.5
Deleting file:    /Users/spindler/Music/iTunes/iTunes Media/Mobile Applications/360 4.0.5.ipa
Application: 3D Wallpapers
Newest:      1.5
Older:       1.4
Deleting file:    /Users/spindler/Music/iTunes/iTunes Media/Mobile Applications/3D Wallpapers 1.4.ipa
Application: 8player lite
Newest:      2.8.2
Older:       2.2.2
Deleting file:    /Users/spindler/Music/iTunes/iTunes Media/Mobile Applications/8player lite 2.2.2.ipa
Application: A+
Newest:      1.5
Older:       1.3
Deleting file:    /Users/spindler/Music/iTunes/iTunes Media/Mobile Applications/A+ 1.3.ipa
Application: Ab Workout
Newest:      3.25
Older:       2.80
Deleting file:    /Users/spindler/Music/iTunes/iTunes Media/Mobile Applications/Ab Workout 2.80.ipa
Application: Abba Bola
Newest:      2.73
Older:       2.073
Deleting file:    /Users/spindler/Music/iTunes/iTunes Media/Mobile Applications/Abba Bola 2.073 1.ipa
Application: Abba Bola
Newest:      2.73
Older:       2.073
Deleting file:    /Users/spindler/Music/iTunes/iTunes Media/Mobile Applications/Abba Bola 2.073.ipa
Application: AccuWeather
Newest:      2.0.1
Older:       1.9.0
Deleting file:    /Users/spindler/Music/iTunes/iTunes Media/Mobile Applications/AccuWeather 1.9.0.ipa
```
