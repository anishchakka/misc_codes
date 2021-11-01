# Miscellaneous code
small bioinformatics helpful codes

## Unix/Bash Commands:

### Find Commands
1. find meth/ -name "201247470004_R03C01_Grn.idat" -print
### Permissions
1. find Liver_MM/ -type d -exec chmod 775 {} \; #directories
2. find Liver_MM/ -type f -exec chmod 664 {} \; #files
3. setfacl -m u:username:r raw_files #set permissions for a user in group


## File Transfers:
1. Command for rsync from HTC to PSC. Adding `/` at the end of `Anish_Projects`, transfers the contents under this folder, but not the folder itself.
rsync -avh --progress -e "ssh -p 2222" Anish_Projects/ abc46@pghbio.bridges.psc.edu:/pghbio/dbmi/Genomics_Core/achakka/File_Transfers/HTC/
2. Macbook to PSC:
rsync -avh --progress -e "ssh -p 2222" T1T2T3candidatesequencelist7_12.fa abc46@pghbio.bridges.psc.edu:/pghbio/dbmi/Genomics_Core/achakka/Misc/Moore/Data
3. Bridges to Bridges2
rsync -avh --progress achakka/ achakka@data.bridges2.psc.edu:/ocean/projects/bio140004p/achakka

## md5sum
1. md5sum --quiet -c file.md5sum
2. find your_folder -type f -exec md5sum ‘{}’ \; > md5sum.txt     ##recursively obtain md5sum values in an entire folder

## Text/Files manipulation
1. First occurrence: ${parameter/pattern/string}
2. All occurrences: ${parameter//pattern/string}
3. head -2 file.maf > all.txt; tail -n +3 -q *.maf >> all.txt

## SLURM
1. sbatch --dependency=afterok:11254323 job2.sh
