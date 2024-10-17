*****************************************************
CPE 365                                 Alex Dekhtyar
Cal Poly		  Computer Science Department
San Luis Obispo                College of Engineering 
California                       dekhtyar@calpoly.edu   
*****************************************************
	      KATZENJAMMER DATASET
                   Version 1.0
                January 12, 2015
*****************************************************
Sources:  this is a hand-made dataset based on actual
          true date. 

******************************************************

This file describes the contents of the KATZENJAMMER 
dataset developed for the CPE 365, Introduction to 
Databases, course at Cal Poly.

The database contains information about the musical 
career of a pop band Kaztenjammer from Norway. The
band consists of four members, each of whom sings and
plays a variety of instruments. The dataset details each
band member's contribution to each song recorded and
performed by the band.


General Conventions.

 1. All files in the dataset are CSV (comma-separated values) files.
 2. First line of each file provides the names of
    columns. Second line may be empty, or may contain
    the first row of the data.
 3. All string values are enclosed in single quotes (')


  The dataset consists of the following files:

       Albums.csv: the list of albums recorded by Katzenjammer
         Band.csv: the list of members of Katzenjammer
  Instruments.csv: instruments the band members play on each song
  Performance.csv: physical location of band members on 
                   stage during live song performances
        Songs.csv: list of songs recorded and performed live
                   by Katzenjammer
   Tracklists.csv: tracklists for all Katzenjammer albums
       Vocals.csv: vocal contributions of the Katzenjammer members
                   to the songs


 Individual files have the following formats.

**************************************************************************

 Albums.csv

       AId: unique identifier of the album
     Title: title of the album
      Year: year the album was released
     Label: label (record company) that released the album


**************************************************************************
 
  Band.csv

         Id: unique id of each band member
  Firstname: first name of each band member
   Lastname: last name of each band member
   

**************************************************************************
 
   Instruments.csv

      SongId: id of the song (see Songs.SongId)
  BandmateId: id of the band member (see Band.Id)
  Instrument: name of the instrument played [1]  
    
  [1] On some songs, some members of Katzenjammer play multiple instruments.
      When this happens, Instruments.csv contains one row per instrument
      played.

**************************************************************************

   Performance.csv
        SongId: id of the song (see Songs.SongId)
      Bandmate: id of the band member (see Band.Id)
 StagePosition: stage position of the band member during the live 
                performances of the song [2]
      
 [2] due to positioning of the instruments the band members play, no band
     member ever changes her position during a single song. All position
     changes are between songs.

**************************************************************************

   Songs.csv

       SongId: unique identifier of the song
        Title: song title

**************************************************************************

   Tracklists.csv

      AlbumId:  id of the album (see Albums.Aid)
     Position:  position of the song on the album (first, second, etc...)
       SongId:  id of the song (see Songs.SongId)


**************************************************************************

   Vocals.csv

      SongId: id of the song (see Songs.SongId)
    Bandmate: id of the band member (see Band.Id)
        Type: type of vocal performance of the band member on the song [3]

[3] Types of vocal performance typically are "lead", "chorus" and "shared".
(there is also a single instance of "rap"). A band member can be listed
for more than one type of vocal peroformance for a given song.

**************************************************************************
**************************************************************************

Permission granted to use and distribute this dataset in its current form, 
provided this file  is kept unchanged and is distributed together with the 
data.

Permission granted to modify and expand this dataset, provided this
file is updated accordingly with new information.

**************************************************************************
**************************************************************************
