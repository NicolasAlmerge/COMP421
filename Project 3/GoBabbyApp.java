// Code by Nicolas Almerge
// Student ID: 260968851

import java.util.ArrayList;
import java.util.Scanner;
import java.sql.*;


/** Represents an appointment. */
class Appointment {
    private final int id;
    private final int pregnid;
    private final String time;
    private final boolean isPrimary;
    private final String mothername;
    private final String hcardid;

    /** Constructor. */
    public Appointment(int id, int pregnid, Time time, boolean isPrimary, String mothername, String hcardid) {
        this.id = id;
        this.pregnid = pregnid;
        this.time = time.toString();
        this.isPrimary = isPrimary;
        this.mothername = mothername;
        this.hcardid = hcardid;
    }

    /** Displays all information. */
    public void showAllInfo(int counter) {
        System.out.printf("%d: %s %c %s %s%n", counter+1, time, isPrimary? 'P': 'B', mothername, hcardid);
    }

    /** Only displays mother name and her health card id. */
    public void showReducedInfo() {
        System.out.printf("For %s %s%n", mothername, hcardid);
    }

    /** Returns appointment id. */
    public int getId() {
        return id;
    }

    /** Returns pregnancy id associated with the appointment. */
    public int getPregnancyId() {
        return pregnid;
    }
}


/** Main class. */
public class GoBabbyApp {
    private static final String url = "jdbc:db2://winter2022-comp421.cs.mcgill.ca:50000/cs421";
    private static final String username = "nalmer";
    private static final String password = "";
    private static final Scanner scanner = new Scanner(System.in);
    private static Connection conn;
    private static Statement stmt;
    private static PreparedStatement prepared;

    /** Retrieves non-empty stripped user input. */
    public static String getInput(String prompt) {
        System.out.print(prompt);
        String res = scanner.nextLine().strip();
        while (res.isEmpty()) {
            System.out.println("No input. Please retry.");
            System.out.print(prompt);
            res = scanner.nextLine().strip();
        }
        return res;
    }

    /** Closes all connections with a successful message. */
    public static void closeAll() {
        closeAll("Successfully closed application.");
    }

    /** Closes all connections with a message. */
    public static void closeAll(String message) {
        scanner.close();
        if (stmt != null)
            try {stmt.close();} catch (SQLException ignored) {}
        if (prepared != null)
            try {prepared.close();} catch (SQLException ignored) {}
        if (conn != null)
            try {conn.close();} catch (SQLException ignored) {}
        System.out.println();
        System.out.println(message);
    }

    /** Fetches all appointments for a specific date and midwife id. */
    public static Appointment[] loadAppointments(Date date, int pid) throws SQLException {
        prepared = conn.prepareStatement(
        "SELECT A.id, A.pregn, P.assistedby, P.backupby, A.atime, M.name, M.hcardid " +
            "FROM Appointment A, Pregnancy P, Couple C, Mother M " +
            "WHERE A.pregn = P.id AND P.cid = C.cid AND C.mcardid = M.hcardid " +
            "AND A.adate = ? AND ((P.assistedby = ? AND A.mainmidwife = 1) OR (P.backupby = ? AND A.mainmidwife = 0)) " +
            "ORDER BY A.atime"
        );

        prepared.setDate(1, date);
        prepared.setInt(2, pid);
        prepared.setInt(3, pid);
        ResultSet appointments = prepared.executeQuery();

        ArrayList<Appointment> result = new ArrayList<>();
        while (appointments.next()) {
            int id = appointments.getInt("id");
            int pregnid = appointments.getInt("pregn");
            Time time = appointments.getTime("atime");
            boolean isPrimary = appointments.getInt("assistedby") == pid;
            String mothername = appointments.getString("name");
            String hcardid = appointments.getString("hcardid");
            result.add(new Appointment(id, pregnid, time, isPrimary, mothername, hcardid));
        }

        appointments.close();

        // Converting to array and returning
        Appointment[] toReturn = new Appointment[result.size()];
        for (int i = 0; i < result.size(); ++i) toReturn[i] = result.get(i);
        return toReturn;
    }

    /** First menu where user inputs a Date.
     * Returns this date or null if 'E' was entered. */
    public static Date firstMenu() {
        while (true) {
            String input = getInput("Please enter the date for appointment list [E] to exit: ");
            if (input.equals("E")) {
                closeAll();
                return null;
            }

            Date date;
            try {
                date = Date.valueOf(input);
            } catch (IllegalArgumentException e) {
                System.out.printf("Date format is invalid. Please retry.%n%n");
                continue;
            }

            return date;
        }
    }

    /** Second menu where user inputs appointment number.
     * Returns this number, 0 if 'D' was entered and '-1' if 'E' was entered. */
    public static int secondMenu(int numberOfAppointments) {
        while (true) {
            System.out.println("Enter the appointment number that you would like to work on.");
            String input = getInput("[E] to exit [D] to go back to another date: ");
            if (input.equals("E")) {
                closeAll();
                return -1;
            }
            if (input.equals("D")) return 0;

            int number;
            try {
                number = Integer.parseInt(input);
            } catch (NumberFormatException e) {
                System.out.println("Number format is invalid. Please retry.");
                continue;
            }

            if (number <= 0 || number > numberOfAppointments) {
                System.out.printf("Number must be between 1 and %d. Please retry.%n", numberOfAppointments);
                continue;
            }

            return number;
        }
    }

    /** Third menu where user enters an option from 1 to 5.
     * Returns this option number. */
    public static int thirdMenu(Appointment appointment) {
        while (true) {
            appointment.showReducedInfo();
            System.out.printf("%n1. Review notes%n2. Review tests%n3. Add a note%n4. Prescribe a test%n5. Go back to the appointments.%n");
            String input = getInput("Enter your choice: ");

            int choice;
            try {
                choice = Integer.parseInt(input);
            } catch (NumberFormatException e) {
                System.out.println("Number format is invalid. Please retry.");
                continue;
            }

            if (choice < 1 || choice > 5) {
                System.out.printf("Number must be between 1 and 5. Please retry.%n");
                continue;
            }

            return choice;
        }
    }

    /** First option to display notes. */
    public static void displayNotes(int pregnid) throws SQLException {
        prepared = conn.prepareStatement(
        "SELECT N.notedate, N.notetime, SUBSTRING(N.content, 1, 50) cont FROM MedicalNote N, Appointment A, Pregnancy P " +
            "WHERE N.appointmentid = A.id AND A.pregn = P.id AND P.id = ? ORDER BY N.notedate DESC, N.notetime DESC"
        );

        prepared.setInt(1, pregnid);
        ResultSet notes = prepared.executeQuery();
        int counter = 0;

        while (notes.next()) {
            ++counter;
            Date date = notes.getDate("notedate");
            Time time = notes.getTime("notetime");
            String content = notes.getString("cont");

            System.out.printf("%s %s %s%n", date.toString(), time.toString(), content);
        }

        notes.close();
        if (counter == 0) System.out.println("No notes found.");
        System.out.println();
    }

    /** Second option to review tests. */
    public static void reviewTests(int pregnid) throws SQLException {
        prepared = conn.prepareStatement(
        "SELECT T.dateprescribed, T.testtype, SUBSTRING(T.result, 1, 50) res FROM MedicalTest T, Appointment A, Pregnancy P " +
            "WHERE T.appointmentid = A.id AND A.pregn = P.id AND P.id = ? AND T.babyid IS NULL ORDER BY T.dateprescribed DESC"
        );

        prepared.setInt(1, pregnid);
        ResultSet tests = prepared.executeQuery();
        int counter = 0;

        while (tests.next()) {
            ++counter;
            Date date = tests.getDate("dateprescribed");
            String type = tests.getString("testtype");
            String result = tests.getString("res");

            System.out.printf("%s [%s] %s%n", date.toString(), type, result == null? "PENDING": result);
        }

        tests.close();
        if (counter == 0) System.out.println("No tests found.");
        System.out.println();
    }

    /** Third option to add a note. */
    public static void addNote(int appointmentid) throws SQLException {
        String note = getInput("Please type your observation: ");

        long curr = System.currentTimeMillis();
        Date date = new Date(curr);
        Time time = new Time(curr);

        prepared = conn.prepareStatement("INSERT INTO MedicalNote(appointmentid, notedate, notetime, content) VALUES(?,?,?,?)");

        prepared.setInt(1, appointmentid);
        prepared.setDate(2, date);
        prepared.setTime(3, time);
        prepared.setString(4, note);
        prepared.executeUpdate();
        System.out.println();
        System.out.println("Successfully added note!");
        System.out.println();
    }

    /** Fourth option to add a test. */
    public static void addTest(int appointmentid) throws SQLException {
        String testtype = getInput("Please enter the type of test: ");

        Date date = new Date(System.currentTimeMillis());
        prepared = conn.prepareStatement("INSERT INTO MedicalTest(testtype, dateprescribed, datesampletaken, appointmentid) VALUES(?,?,?,?)");
        prepared.setString(1, testtype);
        prepared.setDate(2, date);
        prepared.setDate(3, date);
        prepared.setInt(4, appointmentid);
        prepared.executeUpdate();
        System.out.println();
        System.out.println("Successfully added test prescription!");
        System.out.println();
    }

    /** Function to run the application. */
    public static void run() throws SQLException {
        // Setup
        DriverManager.registerDriver(new com.ibm.db2.jcc.DB2Driver());
        conn = DriverManager.getConnection(url, username, password);
        stmt = conn.createStatement();

        // Input practitioner id
        int pid;

        while (true) {
            String input = getInput("Please enter your practitioner id [E] to exit: ");
            if (input.equals("E")) {
                closeAll();
                return;
            }

            try {
                pid = Integer.parseInt(input);
            } catch (NumberFormatException e) {
                System.out.println("Error: pid should be an integer!");
                continue;
            }

            // Check if input is a valid pid
            ResultSet pids = stmt.executeQuery("SELECT pid FROM Midwife");
            boolean isValid = false;
            while (pids.next()) {
                int id = pids.getInt("pid");
                if (id == pid) {
                    isValid = true;
                    break;
                }
            }

            if (isValid) break;
            System.out.println("Error: invalid pid. Please retry.");
        }

        // Useful variables
        boolean goToSecondMenu = false;
        boolean goToThirdMenu = false;
        Date date;
        Appointment[] appointments = null;
        int appointmentNumber = 0;
        System.out.println();

        // Menu loops
        while (true) {
            if (!goToThirdMenu) {
                if (!goToSecondMenu) {
                    // Ask for date
                    date = firstMenu();
                    System.out.println();
                    if (date == null) return; // User pressed 'E' - exit

                    // Load appointments for this date
                    appointments = loadAppointments(date, pid);

                    // If no appointments, ask for another date
                    if (appointments.length == 0) {
                        System.out.println("No appointments found for this date.");
                        continue;
                    }
                }

                goToSecondMenu = false;

                // Display all appointments
                for (int i = 0; i < appointments.length; ++i) appointments[i].showAllInfo(i);
                System.out.println();

                // Ask for a number to decide which appointment to work on
                appointmentNumber = secondMenu(appointments.length);
                System.out.println();
                if (appointmentNumber == -1) return; // User pressed 'E' - exit
                if (appointmentNumber == 0) continue; // User pressed 'D' - go back to previous menu
            }

            goToThirdMenu = false;

            // Get chosen appointment information
            Appointment app = appointments[appointmentNumber-1];
            int appid = app.getId();
            int pregnid = app.getPregnancyId();

            // Ask for a number between 1 and 5 to decide what to do with appointment
            int choice = thirdMenu(app);
            System.out.println();
            switch (choice) {
                // Display notes
                case 1 -> {
                    displayNotes(pregnid);
                    goToThirdMenu = true;
                }

                // Review notes
                case 2 -> {
                    reviewTests(pregnid);
                    goToThirdMenu = true;
                }

                // Add a note
                case 3 -> {
                    addNote(appid);
                    goToThirdMenu = true;
                }

                // Prescribe a test
                case 4 -> {
                    addTest(appid);
                    goToThirdMenu = true;
                }

                // Go back to second menu
                default -> goToSecondMenu = true;
            }
        }
    }

    public static void main(String[] args) {
        try {
            run();
        } catch (SQLException e) {
            System.err.println();
            System.err.println("An error occurred!");
            System.err.println("Message: " + e.getMessage());
            System.err.println("Code: " + e.getErrorCode());
            System.err.println("State: " + e.getSQLState());
            closeAll("Application closed due to error.");
        }
    }
}
