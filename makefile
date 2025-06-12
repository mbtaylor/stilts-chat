
STARJAVA = /mbt/starjava

build: examples.xml

examples.xml: sun256.xml examples.xslt docs.dtd
	@echo Generating $@ from SUN/256
	xsltproc examples.xslt sun256.xml >$@

sun256.xml:
	xmllint --noent $(STARJAVA)/source/ttools/build/docs/sun256.xml >$@

docs.dtd:
	cp $(STARJAVA)/source/xdoc/src/etc/$@ ./

clean:
	rm -f examples.xml

veryclean: clean
	rm -f sun256.xml docs.dtd
	
	
