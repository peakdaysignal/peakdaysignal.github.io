#!/usr/bin/perl
#----------------------------------------------------------------------------
#
#       Purpose: Print out hourly weather data for Chicago and Philly
#
#----------------------------------------------------------------------------
#
#	Variables
#
#----------------------------------------------------------------------------
	chomp($BINDIR=`/usr/bin/dirname $0`);
	system("cd $BINDIR");
#----------------------------------------------------------------------------
#
#	Header
#
#----------------------------------------------------------------------------
        $HTML="html/hourlyweather.html";
	open(OUT,"> $HTML");
	print OUT "<html>
  <head>
<META HTTP-EQUIV=refresh CONTENT=15>
    <title>Hourly Weather Forecast</title>
  </head>
  <body bgcolor=#ffffff>
<center>
     \n";
#----------------------------------------------------------------------------
#
#	Chicago
#
#----------------------------------------------------------------------------
#
#	Get Temperature first
#
#----------------------------------------------------------------------------
	open(IN, "cat data/hchicago.dat | grep \"^T\" | ");
	while ($LINE=<IN>)
	{
		@DATA=split(/\|/,$LINE);
		$TIME=@DATA[1];
		chomp($DAY=`echo $TIME | cut -c1-10`);
		if ( ! $GOT{$DAY} )
		{
			$GOT{$DAY}=1;
			push(@CDAYS, "$DAY");
		}
		chomp($HR=`echo $TIME | cut -c12-13`);
		if ( ! $GOT{$HR} )
		{
			$GOT{$HR}=1;
			push(@CHRS, "$HR");
		}
		chomp($VAL=@DATA[2]);
		$HDAY="{$DAY}{$HR}";
		$TEMP{$HDAY}=$VAL;
	}
	close(IN);
#----------------------------------------------------------------------------
#
#	Get Heat Index
#
#----------------------------------------------------------------------------
	open(IN, "cat data/hchicago.dat | grep \"^I\" | ");
	while ($LINE=<IN>)
	{
		@DATA=split(/\|/,$LINE);
		$TIME=@DATA[1];
		chomp($DAY=`echo $TIME | cut -c1-10`);
		chomp($HR=`echo $TIME | cut -c12-13`);
		chomp($VAL=@DATA[2]);
		$HDAY="{$DAY}{$HR}";
		if ( ! $VAL ) { $VAL=$TEMP{$HDAY}; }
		$HI{$HDAY}=$VAL;
	}
	close(IN);
#----------------------------------------------------------------------------
#
#	Get Chance of Precipitation
#
#----------------------------------------------------------------------------
	open(IN, "cat data/hchicago.dat | grep \"^P\" | ");
	while ($LINE=<IN>)
	{
		@DATA=split(/\|/,$LINE);
		$TIME=@DATA[1];
		chomp($DAY=`echo $TIME | cut -c1-10`);
		chomp($HR=`echo $TIME | cut -c12-13`);
		chomp($VAL=@DATA[2]);
		$HDAY="{$DAY}{$HR}";
		$PP{$HDAY}=$VAL;
	}
	close(IN);
#----------------------------------------------------------------------------
#
#	Get Humidity
#
#----------------------------------------------------------------------------
	open(IN, "cat data/hchicago.dat | grep \"^H\" | ");
	while ($LINE=<IN>)
	{
		@DATA=split(/\|/,$LINE);
		$TIME=@DATA[1];
		chomp($DAY=`echo $TIME | cut -c1-10`);
		chomp($HR=`echo $TIME | cut -c12-13`);
		chomp($VAL=@DATA[2]);
		$HDAY="{$DAY}{$HR}";
		$HUM{$HDAY}=$VAL;
	}
	close(IN);
#----------------------------------------------------------------------------
#
#	Print
#
#----------------------------------------------------------------------------
	print OUT "<h1>Chicago Hourly Forecast</h1>
<table border=1 cellpadding=4 width=50%>\n";
	foreach $DAY (@CDAYS)
	{
		print OUT "<tr><td bgcolor=cccccc>$DAY</td><td>12:00</td><td>13:00</td><td>14:00</td><td>15:00</td><td>16:00</td><td>17:00</td><td>18:00</td></tr>\n";
		print OUT "<tr><td>Temperature</td>";
		foreach $HR (@CHRS)
		{
			$HDAY="{$DAY}{$HR}";
			print OUT "<td>$TEMP{$HDAY}</td>";
		}
		print OUT "</tr>\n";
		print OUT "<tr><td>Humidity</td>";
		foreach $HR (@CHRS)
		{
			$HDAY="{$DAY}{$HR}";
			print OUT "<td>$HUM{$HDAY}</td>";
		}
		print OUT "</tr>\n";
		print OUT "<tr><td>Heat Index</td>";
		foreach $HR (@CHRS)
		{
			$HDAY="{$DAY}{$HR}";
			print OUT "<td>$HI{$HDAY}</td>";
		}
		print OUT "</tr>\n";
		print OUT "<tr><td>Chance of Precipitation</td>";
		foreach $HR (@CHRS)
		{
			$HDAY="{$DAY}{$HR}";
			print OUT "<td>$PP{$HDAY}</td>";
		}
		print OUT "</tr>\n";
	}
	print OUT "</table>\n";
#----------------------------------------------------------------------------
#
#	Philadelphia
#
#----------------------------------------------------------------------------
#
#	Get Temperature first
#
#----------------------------------------------------------------------------
	$PFILE="data/hphiladelphia.dat";
	open(IN, "cat data/hphiladelphia.dat | grep \"^T\" | ");
	while ($LINE=<IN>)
	{
		@DATA=split(/\|/,$LINE);
		$TIME=@DATA[1];
		chomp($DAY=`echo $TIME | cut -c1-10`);
		if ( ! $HAVE{$DAY} )
		{
			$HAVE{$DAY}=1;
			push(@PDAYS, "$DAY");
		}
		chomp($HR=`echo $TIME | cut -c12-13`);
		if ( ! $HAVE{$HR} )
		{
			$HAVE{$HR}=1;
			push(@PHRS, "$HR");
		}
		chomp($VAL=@DATA[2]);
		$HDAY="{$DAY}{$HR}";
		$TEMP{$HDAY}=$VAL;
	}
	close(IN);
#----------------------------------------------------------------------------
#
#	Get Heat Index
#
#----------------------------------------------------------------------------
	open(IN, "cat data/hphiladelphia.dat | grep \"^I\" | ");
	while ($LINE=<IN>)
	{
		@DATA=split(/\|/,$LINE);
		$TIME=@DATA[1];
		chomp($DAY=`echo $TIME | cut -c1-10`);
		chomp($HR=`echo $TIME | cut -c12-13`);
		chomp($VAL=@DATA[2]);
		$HDAY="{$DAY}{$HR}";
		if ( ! $VAL ) { $VAL=$TEMP{$HDAY}; }
		$HI{$HDAY}=$VAL;
	}
	close(IN);
#----------------------------------------------------------------------------
#
#	Get Chance of Precipitation
#
#----------------------------------------------------------------------------
	open(IN, "cat data/hphiladelphia.dat | grep \"^P\" | ");
	while ($LINE=<IN>)
	{
		@DATA=split(/\|/,$LINE);
		$TIME=@DATA[1];
		chomp($DAY=`echo $TIME | cut -c1-10`);
		chomp($HR=`echo $TIME | cut -c12-13`);
		chomp($VAL=@DATA[2]);
		$HDAY="{$DAY}{$HR}";
		$PP{$HDAY}=$VAL;
	}
	close(IN);
#----------------------------------------------------------------------------
#
#	Get Humidity
#
#----------------------------------------------------------------------------
	open(IN, "cat data/hphiladelphia.dat | grep \"^H\" | ");
	while ($LINE=<IN>)
	{
		@DATA=split(/\|/,$LINE);
		$TIME=@DATA[1];
		chomp($DAY=`echo $TIME | cut -c1-10`);
		chomp($HR=`echo $TIME | cut -c12-13`);
		chomp($VAL=@DATA[2]);
		$HDAY="{$DAY}{$HR}";
		$HUM{$HDAY}=$VAL;
	}
	close(IN);
#----------------------------------------------------------------------------
#
#	Print
#
#----------------------------------------------------------------------------
	print OUT "<h1>Philadelphia Hourly Forecast</h1>
<table border=1 cellpadding=4 width=50%>\n";
	foreach $DAY (@PDAYS)
	{
		print OUT "<tr><td bgcolor=cccccc>$DAY</td><td>13:00</td><td>14:00</td><td>15:00</td><td>16:00</td><td>17:00</td><td>18:00</td><td>19:00</td></tr>\n";
		print OUT "<tr><td>Temperature</td>";
		foreach $HR (@PHRS)
		{
			$HDAY="{$DAY}{$HR}";
			print OUT "<td>$TEMP{$HDAY}</td>";
		}
		print OUT "</tr>\n";
		print OUT "<tr><td>Humidity</td>";
		foreach $HR (@PHRS)
		{
			$HDAY="{$DAY}{$HR}";
			print OUT "<td>$HUM{$HDAY}</td>";
		}
		print OUT "</tr>\n";
		print OUT "<tr><td>Heat Index</td>";
		foreach $HR (@PHRS)
		{
			$HDAY="{$DAY}{$HR}";
			print OUT "<td>$HI{$HDAY}</td>";
		}
		print OUT "</tr>\n";
		print OUT "<tr><td>Chance of Precipitation</td>";
		foreach $HR (@PHRS)
		{
			$HDAY="{$DAY}{$HR}";
			print OUT "<td>$PP{$HDAY}</td>";
		}
		print OUT "</tr>\n";
	}
	print OUT "</table></center>
  </body>
</html>\n";
	close(OUT);



