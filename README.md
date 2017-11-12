# vcfConverter
Convert a *.vcf file with multiple vCards into a set of single-content files (which can be imported into Outlook).

Many email software allows to save your contact list as a *.vcf file for data exchange, backups, and so on. 
However, importing such a file into your email software is not well supported -- at least by Outlook. It only allows to import a single *.vcf file consisting of a single vCard. This becomes an issue if you want to switch to another software, or change your device (smartphone, computer, ...). 

This is a simple PowerShell function that splits an input file with multiple vCards into a set of files, each with a single vCard.
