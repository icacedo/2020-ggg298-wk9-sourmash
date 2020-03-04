#
SAMPLES=['1','2','3','4','5']
GRAPHS=['hist','dendro','matrix']

rule all:
	input:
		# don't need the expand here anymore since it's in the rule run_sourmash_compare, but it can still stay here
		expand("{num}.fa.gz.sig", num=SAMPLES),
		"all.cmp",
		expand("all.cmp.{type}.png", type=GRAPHS)

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
		"{num}.fa.gz"
	output:
		"{num}.fa.gz.sig"
	shell: 
		"sourmash compute -k 31 {input}"

rule run_sourmash_compare:
	input:
		expand("{num}.fa.gz.sig", num=SAMPLES)
	output:
		"all.cmp"
	shell:
		"sourmash compare {input} -o all.cmp"

rule run_sourmash_plot:
	input:
		"all.cmp",
		"all.cmp.labels.txt"
	output:
		"all.cmp.hist.png",
		"all.cmp.dendro.png",
		"all.cmp.matrix.png"
	shell:
		"sourmash plot --labels all.cmp"








