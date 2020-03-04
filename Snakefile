#
SAMPLES=['1','2','3','4','5']

rule all:
	input:
		expand("{num}.fa.gz.sig", num=SAMPLES)

rule download_genome_files:
	output:
		"1.fa.gz",
		"2.fa.gz",
		"3.fa.gz",
		"4.fa.gz",
		"5.fa.gz"
	shell: 
		"""wget https://osf.io/t5bu6/download -O 1.fa.gz
		wget https://osf.io/ztqx3/download -O 2.fa.gz
		wget https://osf.io/w4ber/download -O 3.fa.gz
		wget https://osf.io/dnyzp/download -O 4.fa.gz
		wget https://osf.io/ajvqk/download -O 5.fa.gz"""

rule run_sourmash_compute:
	input:
		"{num}.fa.gz",
	output:
		"{num}.fa.gz.sig",
	shell: 
		"sourmash compute --scaled 1000 -k 31 {input} --name-from-first"
