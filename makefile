# You may need to set the environment variable STAR_JAVA to
# a java executable in a JDK.

STARJAVA = starjava

JSRC = CommandValidator.java

build: examples.xml chat.jar

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

manifest:
	echo "Main-Class: CommandValidator" >$@
	echo "Class-Path: $(STARJAVA)/lib/ttools/ttools.jar" >>$@

chat.jar: $(JSRC) $(STARJAVA)/lib/ttools/ttools.jar manifest
	rm -rf tmp
	mkdir -p tmp
	javac -classpath $(STARJAVA)/lib/ttools/ttools.jar -d tmp $(JSRC) \
           && jar cfm $@ manifest -C tmp .
	
clean:
	rm -f examples.xml chat.jar manifest
	rm -rf tmp

veryclean: clean starjava-clean
	rm -f sun256.xml docs.dtd
