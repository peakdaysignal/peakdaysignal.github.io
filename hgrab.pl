#!/usr/bin/perl
#----------------------------------------------------------------------------
#
#       Purpose: Grab hourly weather data for Chicago and Philly
#
#----------------------------------------------------------------------------
#
#       Variables
#
#----------------------------------------------------------------------------
	chomp($BINDIR=`/usr/bin/dirname $0`);
	system("cd $BINDIR");

	$TEMP="tmp/temp.dat";

	$CTEMP="tmp/hchicago.dat";
	$CFILE="data/hchicago.dat";
	$CFILE2="html/hchicago.html";

	$CURL="http://forecast.weather.gov/MapClick.php?lat=41.88&lon=-87.70&FcstType=digitalDWML";
	$CURL2="http://forecast.weather.gov/MapClick.php?lat=41.88&lon=-87.70&unit=0&lg=english&FcstType=digital";

	$PTEMP="tmp/hphiladelphia.dat";
	$PFILE="data/hphiladelphia.dat";
	$PFILE2="html/hphilly.html";
	$PURL="http://forecast.weather.gov/MapClick.php?lat=39.95234&lon=-75.16379&FcstType=digitalDWML";
	$PURL2="http://forecast.weather.gov/MapClick.php?lat=39.95234&lon=-75.16379&unit=0&lg=english&FcstType=digital";
#----------------------------------------------------------------------------
#
#       Days
#
#----------------------------------------------------------------------------
	chomp($ONE=`date +\"%Y-%m-%d\"`);
	chomp($TWO=`date --date=\"1 days\" +\"%Y-%m-%d\"`);
	chomp($THREE=`date --date=\"2 days\" +\"%Y-%m-%d\"`);
	chomp($FOUR=`date --date=\"3 days\" +\"%Y-%m-%d\"`);
	chomp($FIVE=`date --date=\"4 days\" +\"%Y-%m-%d\"`);
	chomp($SIX=`date --date=\"5 days\" +\"%Y-%m-%d\"`);
	chomp($SEVEN=`date --date=\"6 days\" +\"%Y-%m-%d\"`);
#----------------------------------------------------------------------------
#
#       Grab Chicago
#
#----------------------------------------------------------------------------
	$i=0; #heat Index
	$h=0; #Humidity
	$t=0; #Temp
	$p=0; #Precip
	system("/usr/bin/wget \"$CURL\" -O $TEMP >>/tmp/err.log 2>&1");
	system("/usr/bin/wget \"$CURL2\" -O $CFILE2 >>/tmp/err.log 2>&1");
	open(OUT,"> $CFILE");
	system("cat $TEMP | sed 's/<value/\\\n<value/g' > $CTEMP");
	open( WGET, "cat $CTEMP | ");
	while ($LINE=<WGET>)
	{
		chomp($LINE);
		if ($LINE =~ /start-valid-time/ )
		{
			@ADATA=split(/\>/,$LINE);
			@BDATA=split(/\</,@ADATA[1]);
			$TIME=@BDATA[0];
			push(@TIMES, "$TIME");
		}
		if ($LINE =~ /cloud-amount/ ) { $FLAG="N"; }
		if ($LINE =~ /weather-conditions/ ) { $FLAG="N"; }
		if ($LINE =~ /wind/ ) { $FLAG="N"; }
		if ($LINE =~ /dew point/ ) { $FLAG="N"; }
		if ($LINE =~ /qpf/ ) { $FLAG="N"; }
		if ($LINE =~ /humidity/ ) { $FLAG="H"; }
		if ($LINE =~ /temperature/ && $LINE =~ /hourly/ ) { $FLAG="T"; }
		if ($LINE =~ /heat index/ ) { $FLAG="I"; }
		if ($LINE =~ /probability-of-precipitation/ ) { $FLAG="P"; }
		if ($FLAG eq "P" && $LINE =~ /value/ )
		{
			@ADATA=split(/\>/,$LINE);
			@BDATA=split(/\</,@ADATA[1]);
			if ( @TIMES[$p] =~ /T1[2-8]:00:00/ )
			{
				print OUT "P|@TIMES[$p]|@BDATA[0]\n";
			}
			$p++;
		}
		if ($FLAG eq "T" && $LINE =~ /value/ )
		{
			@ADATA=split(/\>/,$LINE);
			@BDATA=split(/\</,@ADATA[1]);
			if ( @TIMES[$t] =~ /T1[2-8]:00:00/ )
			{
				print OUT "T|@TIMES[$t]|@BDATA[0]\n";
			}
			$t++;
		}
		if ($FLAG eq "H" && $LINE =~ /value/ )
		{
			@ADATA=split(/\>/,$LINE);
			@BDATA=split(/\</,@ADATA[1]);
			if ( @TIMES[$h] =~ /T1[2-8]:00:00/ )
			{
				print OUT "H|@TIMES[$h]|@BDATA[0]\n";
			}
			$h++;
		}
		if ($FLAG eq "I" && $LINE =~ /value/ )
		{
			@ADATA=split(/\>/,$LINE);
			@BDATA=split(/\</,@ADATA[1]);
			if ( @TIMES[$i] =~ /T1[2-8]:00:00/ )
			{
				print OUT "I|@TIMES[$i]|@BDATA[0]\n";
			}
			$i++;
		}
	}
	close(WGET);
	close(OUT);
#----------------------------------------------------------------------------
#
#       Grab Philly
#
#----------------------------------------------------------------------------
	$i=0; #heat Index
	$h=0; #Humidity
	$t=0; #Temp
	$p=0; #Precip
	system("/usr/bin/wget \"$PURL\" -O $TEMP >>/tmp/err.log 2>&1");
	system("/usr/bin/wget \"$PURL2\" -O $PFILE2 >>/tmp/err.log 2>&1");
	open(OUT,"> $PFILE");
	system("cat $TEMP | sed 's/<value/\\\n<value/g' > $PTEMP");
	open( WGET, "cat $PTEMP | ");
	while ($LINE=<WGET>)
	{
		chomp($LINE);
		if ($LINE =~ /start-valid-time/ )
		{
			@ADATA=split(/\>/,$LINE);
			@BDATA=split(/\</,@ADATA[1]);
			$TIME=@BDATA[0];
			push(@TIMES, "$TIME");
		}
		if ($LINE =~ /cloud-amount/ ) { $FLAG="N"; }
		if ($LINE =~ /weather-conditions/ ) { $FLAG="N"; }
		if ($LINE =~ /wind/ ) { $FLAG="N"; }
		if ($LINE =~ /dew point/ ) { $FLAG="N"; }
		if ($LINE =~ /qpf/ ) { $FLAG="N"; }
		if ($LINE =~ /humidity/ ) { $FLAG="H"; }
		if ($LINE =~ /temperature/ && $LINE =~ /hourly/ ) { $FLAG="T"; }
		if ($LINE =~ /heat index/ ) { $FLAG="I"; }
		if ($LINE =~ /probability-of-precipitation/ ) { $FLAG="P"; }
		if ($FLAG eq "P" && $LINE =~ /value/ )
		{
			@ADATA=split(/\>/,$LINE);
			@BDATA=split(/\</,@ADATA[1]);
			if ( @TIMES[$p] =~ /T1[3-9]:00:00/ )
			{
				print OUT "P|@TIMES[$p]|@BDATA[0]\n";
			}
			$p++;
		}
		if ($FLAG eq "T" && $LINE =~ /value/ )
		{
			@ADATA=split(/\>/,$LINE);
			@BDATA=split(/\</,@ADATA[1]);
			if ( @TIMES[$t] =~ /T1[3-9]:00:00/ )
			{
				print OUT "T|@TIMES[$t]|@BDATA[0]\n";
			}
			$t++;
		}
		if ($FLAG eq "H" && $LINE =~ /value/ )
		{
			@ADATA=split(/\>/,$LINE);
			@BDATA=split(/\</,@ADATA[1]);
			if ( @TIMES[$h] =~ /T1[3-9]:00:00/ )
			{
				print OUT "H|@TIMES[$h]|@BDATA[0]\n";
			}
			$h++;
		}
		if ($FLAG eq "I" && $LINE =~ /value/ )
		{
			@ADATA=split(/\>/,$LINE);
			@BDATA=split(/\</,@ADATA[1]);
			if ( @TIMES[$i] =~ /T1[3-9]:00:00/ )
			{
				print OUT "I|@TIMES[$i]|@BDATA[0]\n";
			}
			$i++;
		}
	}
	close(WGET);
	close(OUT);


