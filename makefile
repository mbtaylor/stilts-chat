# You may need to set the environment variable STAR_JAVA to
# a java executable in a JDK.

STARJAVA = starjava

build: examples.xml

examples.xml: sun256.xml examples.xslt docs.dtd
	@echo Generating $@ from SUN/256
	xsltproc examples.xslt sun256.xml >$@

starjava/source/ttools/build/docs/sun256.xml \
starjava/lib/ttools/stilts-app.jar:
	starjava/source/ant/bin/ant -f starjava/source/build.xml build install

starjava-clean:
	starjava/source/ant/bin/ant -f starjava/source/build.xml deinstall clean

sun256.xml: $(STARJAVA)/source/ttools/build/docs/sun256.xml
	xmllint --noent $(STARJAVA)/source/ttools/build/docs/sun256.xml >$@

docs.dtd:
	cp $(STARJAVA)/source/xdoc/src/etc/$@ ./

clean:
	rm -f examples.xml

veryclean: clean starjava-clean
	rm -f sun256.xml docs.dtd
	
	
