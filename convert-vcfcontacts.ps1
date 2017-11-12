# Split a file with multiple vcf card into a set of single-content *.vcf files.
#
# Note: Outlook can import only *.vcf files consisting of a single VCF entry, 
# and the file must be encoded in ASCII format (or UTF without BOM).
# 
# Author: Roman Fuchs, roman.fuchs@hotmail.com
# Date: November 12, 2017
#
function convert-vcfcontacts 
{
	Param(
		[string] $inputfile
	) 
	# Output file format: (contact-k.vcf)
	$basename = "contact-";
	$extension = ".vcf"

	# Check if such files already exist
	$filename = $basename + "*" + $extension
	if (Test-Path $filename) {
		write-output ("There exist already files matching: " + $filename)
		write-output "Please remove those files"
	}

	# Input file with multiple vcf cards
	#$inputfile = "contacts_backup_12.11.17.vcf"
	$filecontent = get-content $inputfile

	# Number of lines in input file
	$Nfilecontent = $filecontent.Length
	if ($Nfilecontent -le 0) {
		write-output ("Cannot read input file: " + $inputfile)
		return
	}

	# For debugging purposes: upper limit of VCF output files
	$Nfiles = $Nfilecontent;

	$k = 0;
	$filename = $basename + ($k++) + $extension

	# Write all input file content to output files, line by line
	for ($m = 0; $m -lt $Nfilecontent; $m++) {

		# Write one line into output file
		$mytext = $filecontent[$m] 
		$mytext | out-file $filename -Append -Encoding ASCII
		
		# If this line indicates end of a VCF card, create a new output file
		if ($mytext -eq "END:VCARD") {
			$filename = $basename + ($k++) + $extension
			
			$Nfiles = $Nfiles - 1
			if ($Nfiles -lt 0) {
				break
			}
			
			if ($k % 10 -eq 0) {
				write-output ("contact number: " + $k)
			}
		}
	}

	write-output ("Converted to " + $k + " contact files") 
}