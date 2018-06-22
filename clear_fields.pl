#!/usr/bin/perl

#use Text::CSV;
#my $csv = Text::CSV->new({ sep_char => ',' });

my $date = @ARGV[0];
my $year, $month, $day;

# Check for -h or valid date parameter; show Usage if invalid
if (defined($date)) {
  if (("-h" == $date) or (8 != length($date))) {
    print "USAGE: clear_fields.pl <20180430> (start date to for cleaning; missing date using today)\n\n";
    exit 0;
  }
  
  $year = substr $date, 0, 4;
  $month = substr $date, 4, 2;
  $day = substr $date, 6, 2;
}
else {
  # Default to current date if not given
  my (undef,undef,undef,$mday,$mon,$myear) = localtime;
  $year = $myear+1900;
  $month = $mon += 1;
  $day = $mday
}

# Bad tickers (in a hash, for performance)
my %bad_tickers = (
	CVY => 1,
	DWAQ => 1,
	EQWS => 1,
	EWSC => 1,
	FMK => 1,
	FNK => 1,
	FNX => 1,
	FTCS => 1,
	FTLS => 1,
	FTXG => 1,
	FXD => 1,
	GMFL => 1,
	JDIV => 1,
	JMIN => 1,
	JMOM => 1,
	JPED => 1,
	JPGE => 1,
	JPHF => 1,
	JPLS => 1,
	JPME => 1,
	JPSE => 1,
	JPUS => 1,
	JQUA => 1,
	JVAL => 1,
	LALT => 1,
	PBJ => 1,
	PBSM => 1,
	PBUS => 1,
	PDP => 1,
	PEY => 1,
	PEZ => 1,
	PFIG => 1,
	PFM => 1,
	PKW => 1,
	PRF => 1,
	PRN => 1,
	PSCD => 1,
	PSJ => 1,
	PSL => 1,
	PTF => 1,
	PWB => 1,
	PWC => 1,
	RDVY => 1,
	RFCI => 1,
	RFG => 1,
	RFV => 1,
	RHS => 1,
	RNMC => 1,
	RSP => 1,
	RYH => 1,
	RYJ => 1,
	RYU => 1,
	RZV => 1,
	SDVY => 1,
	SPHB => 1,
	SPHD => 1,
	SPHQ => 1,
	SPMO => 1,
	SPVM => 1,
	SPVU => 1,
	TUSA => 1,
	USLB => 1);

# Load all constituent files
@files = <*_constituents.csv>;

foreach $file (@files) {
  if ($file =~ /(\d{4})-(\d{2})-(\d{2})_constituents/) {
    $fyear = $1;
    $fmon = $2;
    $fday = $3;
    
    if (($fyear >= $year) and ($fmon >= $mon)) {
      if ($fmon == $mon) and ($fday < $day) {
        next;
      }
      
      print "Processing $file...\n";
      
      # Rename original
      $backup = $file;
      $backup =~ s/csv$/bak/;
      
      `mv $file $backup`;
      
	  open(FIN, "<", $backup) or die "Could not open '$backup' $!\n";
	  open(FOUT, ">", $file) or die "Can't write $file $!\n";
	  
	  while (my $line = <FIN>) {
		chomp $line;
		@fields = split /,/, $line;
		
		if (15 == scalar(@fields)) {
		  # If the field is valid, all is well 
		  &emit(FOUT, $line, @fields);
		}
		else {
		  # Count is off - remove embedded commas and reparse
		  $fixed = &fix_line($line);
          @fields = split /,/, $fixed;
          
		  if (15 == scalar(@fields)) {
		    # If the reparse worked, all is well
		    &emit(FOUT, $line, @fields)
		  }
		  else {
		    # It didn't work; line is uncertain. If it doesn't contain the ticker, we don't care; just print it
		    # Otherwise show a warning
		    foreach $ticker (keys %bad_tickers) {
		      if ($line =~ /$ticker/) {
		        warn "Not able to clean this line!\n";
		        print "$line\n";
		        
		        last;
		      }
		    }
		    
	        # Just emit anyway - no bad ticker, no problem
	        print FOUT "$line\n";		    
		  }
		}
	  }
	  close($fin);
    }
    else {
      print "Skipping $file...\n"
    }
  }
}

sub fix_line {
  my $ln = @_[0];
  
  #print "BEFORE: $ln\n";
  $ln =~ s/((?:\G(?!\A)|[^"]*")[^",]*)(?:,|("[^"]*(?:"|\z)))/$1$2/g;
  #print "AFTER: $ln\n";
  return $ln;
}

sub emit {
  my ($fh, $row, @fields) = @_;
  
  if ($bad_tickers{$fields[1]}) {
    $fields[7] = "";
    $fields[8] = "";
    $fields[9] = "";
    $fields[10] = "";
    $fields[11] = "";
    $fields[13] = "";
    $fields[14] = "";
    
    $newline = join(",", @fields);
    #print "CHANGED ROW:\n$row\n$newline\n";
    print $fh "$newline\n";
  }
  else {
    # Ticker not present, just output the line
    print $fh "$row\n";
  }
}
