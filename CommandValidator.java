
import java.io.IOException;
import uk.ac.starlink.table.EmptyStarTable;
import uk.ac.starlink.table.StarTable;
import uk.ac.starlink.table.StarTableFactory;
import uk.ac.starlink.task.Executable;
import uk.ac.starlink.task.TaskException;
import uk.ac.starlink.ttools.Stilts;
import uk.ac.starlink.ttools.task.LineInvoker;
import uk.ac.starlink.ttools.task.LineTableEnvironment;
import uk.ac.starlink.util.ObjectFactory;

/**
 * Tool for validation of STILTS command lines.
 * Feed it a STILTS command on the command line, and it will
 * either complete with a 0 status (no errors) or
 * report an error and complete with a 1 status.
 *
 * <p>It's not bulletproof.  In particular, since it's not expecting
 * to be invoked in the presence of actual data,
 * it doesn't attempt to read tables, it just assumes that a named
 * input file can be read, and turns it into a dummy (no columns, no rows)
 * table.  In some cases, that will affect later analysis of input
 * parameters which it may therefore get wrong.
 * But it will work in many/most situations.
 *
 * @author   Mark Taylor
 * @since    13 Jun 2025
 */
public class CommandValidator extends LineInvoker {

    private StarTableFactory dummyTfact_;

    public CommandValidator() {
        super( "stilts", Stilts.getTaskFactory() );
        dummyTfact_ = new StarTableFactory() {
            @Override
            public StarTable makeStarTable( String loc, String fmt ) {
                return new EmptyStarTable();
            }
        };
        Stilts.addStandardSchemes( dummyTfact_ );
    }

    public int checkInvocation( String[] args ) {
        return invoke( args, () -> {} );
    }


    @Override
    protected void execute( Executable exec )
            throws TaskException, IOException {
        // Don't execute.
    }

    @Override
    public LineTableEnvironment createEnvironment() {
        LineTableEnvironment env = super.createEnvironment();
        env.setTableFactory( dummyTfact_ );
        env.setInteractive( false );
        return env;
    }

    public static void main( String[] args ) {
        CommandValidator cv = new CommandValidator();
        if ( cv.checkInvocation( args ) != 0 ) {
            System.exit( 1 );
        }
    }
}
