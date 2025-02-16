name=document
default:
	pdflatex -- $(name).tex

clean:
	if [ -f $(name).aux ]; then rm -- $(name).aux; fi
	if [ -f $(name).idx ]; then rm -- $(name).idx; fi
	if [ -f $(name).log ]; then rm -- $(name).log; fi
	if [ -f $(name).out ]; then rm -- $(name).out; fi
	if [ -f $(name).toc ]; then rm -- $(name).toc; fi


