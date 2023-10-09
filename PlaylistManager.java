//PLAYLIST MANAGER APP --- Creator:(NAME SURNAME: Burak EVREN, STUDENT ID: 12515187190, GROUP NO: 57, PROJECT NO: 7)
import javax.swing.*;
import javax.swing.table.DefaultTableModel;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.sql.*;
import java.util.HashMap;
import java.util.Map;
public class PlaylistManager extends JFrame {
    private JLabel loggedInUserLabel;
    private String loggedInUser;
    private JTextField usernameField;
    private JPasswordField passwordField;
    private JTextField playlistNameField;
    private JTextField ageField;
    private JTextField countryField;
    private JTextField permissionField;
    private JTextField durationField;
    private Connection connection;
    private Statement statement;
    private PreparedStatement preparedStatement;
    private JTextField creatorField;
    private JComboBox<String> songList;
    private JTabbedPane tabbedPane;
    private JPanel playlistCreationPanel;
    private JPanel allSongsPanel;
    private JPanel createdPlaylistsPanel;
    private Map<String, String> songDurations = new HashMap<>();

    public PlaylistManager() {
        // GUI initialization
        setTitle("Playlist Manager");
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setSize(800, 400);
        setLocationRelativeTo(null);

        // Information box for logged-in user
        loggedInUserLabel = new JLabel("Logged-in User: ");
        JPanel infoPanel = new JPanel(new FlowLayout(FlowLayout.LEFT));
        infoPanel.add(loggedInUserLabel);

        // Login panel
        JPanel loginPanel = new JPanel(new GridLayout(3, 2));
        loginPanel.add(new JLabel("Username:"));
        usernameField = new JTextField();
        loginPanel.add(usernameField);
        loginPanel.add(new JLabel("Password:"));
        passwordField = new JPasswordField();
        loginPanel.add(passwordField);
        JButton loginButton = new JButton("Login");
        loginButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                loginUser();
            }
        });
        loginPanel.add(loginButton);

        // User registration form
        JPanel userRegistrationPanel = new JPanel(new GridLayout(6, 1));
        userRegistrationPanel.add(new JLabel("Username:"));
        JTextField registerUsernameField = new JTextField();
        userRegistrationPanel.add(registerUsernameField);
        userRegistrationPanel.add(new JLabel("Password:"));
        JPasswordField registerPasswordField = new JPasswordField();
        userRegistrationPanel.add(registerPasswordField);
        userRegistrationPanel.add(new JLabel("Age:"));
        ageField = new JTextField();
        userRegistrationPanel.add(ageField);
        userRegistrationPanel.add(new JLabel("Country:"));
        countryField = new JTextField();
        userRegistrationPanel.add(countryField);
        userRegistrationPanel.add(new JLabel("Permission:"));
        permissionField = new JTextField();
        userRegistrationPanel.add(permissionField);
        JButton registerButton = new JButton("Register");
        registerButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                registerUser(registerUsernameField.getText().trim(), new String(registerPasswordField.getPassword()),
                        ageField.getText().trim(), countryField.getText().trim(), permissionField.getText().trim());
            }
        });
        userRegistrationPanel.add(registerButton);

        /// Playlist creation form
        playlistCreationPanel = new JPanel(new GridLayout(5, 2));
        playlistCreationPanel.add(new JLabel("Playlist Name:"));
        playlistNameField = new JTextField();
        playlistCreationPanel.add(playlistNameField);
        playlistCreationPanel.add(new JLabel("Creator:"));
        creatorField = new JTextField();
        playlistCreationPanel.add(creatorField);
        playlistCreationPanel.add(new JLabel("Song Titles:"));
        DefaultComboBoxModel<String> songComboBoxModel = new DefaultComboBoxModel<>();
        songList = new JComboBox<>(songComboBoxModel);
        songList.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                updateDurationField();
            }
        });
        playlistCreationPanel.add(songList);
        playlistCreationPanel.add(new JLabel("Duration:"));
        durationField = new JTextField();
        durationField.setEditable(false); // Make the duration field read-only
        playlistCreationPanel.add(durationField);
        JButton createPlaylistButton = new JButton("Create Playlist");
        createPlaylistButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                createPlaylist();
            }
        });
        playlistCreationPanel.add(createPlaylistButton);

        // Main page
        tabbedPane = new JTabbedPane();
        tabbedPane.addTab("Login", loginPanel);
        tabbedPane.addTab("User Registration", userRegistrationPanel);
        tabbedPane.addTab("Playlist Creation", playlistCreationPanel);
        tabbedPane.setEnabledAt(2, false); // Disable the "Playlist Creation" tab initially

        // Add components to the frame
        getContentPane().add(tabbedPane);

        // Create a container panel to hold the components
        JPanel containerPanel = new JPanel(new BorderLayout());
        containerPanel.add(infoPanel, BorderLayout.NORTH);
        containerPanel.add(tabbedPane, BorderLayout.CENTER);

        // Add the container panel to the frame
        getContentPane().add(containerPanel);

        // Initialize database connection
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/musicplaylist", "root", "Project.2023");
            statement = connection.createStatement(); // Initialize the statement variable
            loadSongTitles();
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        // Create the "All Songs" tab
        JPanel allSongsTabPanel = new JPanel();
        tabbedPane.addTab("All Songs", allSongsTabPanel);
        populateAllSongsTab();
        tabbedPane.setComponentAt(3, allSongsPanel);

        // Create the "Created Playlists" tab
        createdPlaylistsPanel = new JPanel(new BorderLayout());
        tabbedPane.addTab("Created Playlists", createdPlaylistsPanel);
        populateCreatedPlaylistsTab();
    }

    private void loginUser() {
        String username = usernameField.getText().trim();
        String password = new String(passwordField.getPassword());

        try {
            String sql = "SELECT * FROM user WHERE username = ? AND password = ?";
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, username);
            preparedStatement.setString(2, password);
            ResultSet resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                loggedInUser = username;
                loggedInUserLabel.setText("Logged-in User: " + loggedInUser);

                // Auto-complete the Creator field in the playlist creation panel
                creatorField.setText(loggedInUser);

                JOptionPane.showMessageDialog(this, "Login successful!");

                // Enable the "Playlist Creation" tab
                tabbedPane.setEnabledAt(2, true);
                tabbedPane.setSelectedIndex(2); // Switch to the "Playlist Creation" tab
            } else {
                JOptionPane.showMessageDialog(this, "Invalid username or password.");
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
            JOptionPane.showMessageDialog(this, "Error occurred while logging in!");
        }
    }

    private void registerUser(String username, String password, String age, String country, String permission) {
        try {
            // Insert the user into the "user" table
            String sql = "INSERT INTO user (username, age, permission, password, country) VALUES (?, ?, ?, ?, ?)";
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, username);
            preparedStatement.setString(2, age);
            preparedStatement.setString(3, permission);
            preparedStatement.setString(4, password);
            preparedStatement.setString(5, country);
            preparedStatement.executeUpdate();

            loggedInUser = username;
            loggedInUserLabel.setText("Logged-in User: " + loggedInUser);

            // Auto-complete the Creator field in the playlist creation panel
            creatorField.setText(loggedInUser);

            JOptionPane.showMessageDialog(this, "User registered successfully!");

            // Enable the "Playlist Creation" tab
            tabbedPane.setEnabledAt(2, true);
            tabbedPane.setSelectedIndex(2); // Switch to the "Playlist Creation" tab
        } catch (SQLException ex) {
            ex.printStackTrace();
            JOptionPane.showMessageDialog(this, "Error occurred while registering user!");
        }
    }
    private void updateDurationField() {
        String selectedSong = (String) songList.getSelectedItem();
        if (selectedSong != null) {
            String duration = songDurations.get(selectedSong);
            durationField.setText(duration);
        } else {
            durationField.setText("");
        }
    }

    private void createPlaylist() {
        String playlistName = playlistNameField.getText().trim();
        String creator = loggedInUser;
        String selectedSong = (String) songList.getSelectedItem(); // Get the currently selected song

        if (playlistName.isEmpty()) {
            JOptionPane.showMessageDialog(this, "Please enter a playlist name.");
            return;
        }

        if (selectedSong == null) {
            JOptionPane.showMessageDialog(this, "Please select a song.");
            return;
        }

        String duration = songDurations.get(selectedSong); // Get the duration of the selected song

        try {
            // Insert the playlist into the "p_data" table
            String sql = "INSERT INTO p_data (playlist_name, creator, song_title, song_duration) VALUES (?, ?, ?, ?)";
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, playlistName);
            preparedStatement.setString(2, creator);
            preparedStatement.setString(3, selectedSong);
            preparedStatement.setString(4, duration);
            preparedStatement.executeUpdate();

            JOptionPane.showMessageDialog(this, "Playlist created successfully!");

            // Display the duration in the durationField
            durationField.setText(duration);
            playlistNameField.requestFocus(); // Set focus back to the playlist name field

            // Update the "Created Playlists" tab
            populateCreatedPlaylistsTab();
        } catch (SQLException ex) {
            ex.printStackTrace();
            JOptionPane.showMessageDialog(this, "Error occurred while creating the playlist!");
        }
    }

    private void populateCreatedPlaylistsTab() {
        createdPlaylistsPanel.removeAll();

        try {
            String sql = "SELECT * FROM p_data";
            ResultSet resultSet = statement.executeQuery(sql);

            // Create a table model to hold the data from the ResultSet
            DefaultTableModel tableModel = new DefaultTableModel();
            ResultSetMetaData metaData = resultSet.getMetaData();

            // Get the column count from the ResultSet metadata
            int columnCount = metaData.getColumnCount();

            // Add column names to the table model
            for (int column = 1; column <= columnCount; column++) {
                tableModel.addColumn(metaData.getColumnName(column));
            }

            // Add rows to the table model
            while (resultSet.next()) {
                Object[] rowData = new Object[columnCount];
                for (int column = 1; column <= columnCount; column++) {
                    rowData[column - 1] = resultSet.getObject(column);
                }
                tableModel.addRow(rowData);
            }

            // Create the JTable with the table model
            JTable playlistTable = new JTable(tableModel);

            // Create a scroll pane for the table
            JScrollPane scrollPane = new JScrollPane(playlistTable);

            // Add the scroll pane to the panel
            createdPlaylistsPanel.add(scrollPane, BorderLayout.CENTER);

            // Refresh the panel to update the changes
            createdPlaylistsPanel.revalidate();
            createdPlaylistsPanel.repaint();
        } catch (SQLException ex) {
            ex.printStackTrace();
            JOptionPane.showMessageDialog(this, "Error occurred while loading playlist data!");
        }
    }

    private void populateAllSongsTab() {
        allSongsPanel = new JPanel(new BorderLayout());

        try {
            String sql = "SELECT * FROM comp_table";
            ResultSet resultSet = statement.executeQuery(sql);

            // Create a table model to hold the data from the ResultSet
            DefaultTableModel tableModel = new DefaultTableModel();
            ResultSetMetaData metaData = resultSet.getMetaData();

            // Get the column count from the ResultSet metadata
            int columnCount = metaData.getColumnCount();

            // Add column names to the table model
            for (int column = 1; column <= columnCount; column++) {
                tableModel.addColumn(metaData.getColumnName(column));
            }

            // Add rows to the table model
            while (resultSet.next()) {
                Object[] rowData = new Object[columnCount];
                for (int column = 1; column <= columnCount; column++) {
                    rowData[column - 1] = resultSet.getObject(column);
                }
                tableModel.addRow(rowData);
            }

            // Create the JTable with the table model
            JTable compTable = new JTable(tableModel);

            // Create a scroll pane for the table
            JScrollPane scrollPane = new JScrollPane(compTable);

            // Add the scroll pane to the panel
            allSongsPanel.add(scrollPane, BorderLayout.CENTER);
        } catch (SQLException ex) {
            ex.printStackTrace();
            JOptionPane.showMessageDialog(this, "Error occurred while loading song data!");
        }
    }

    private void loadSongTitles() {
        try {
            String sql = "SELECT s_title, duration FROM song";
            ResultSet resultSet = statement.executeQuery(sql);

            while (resultSet.next()) {
                String title = resultSet.getString("s_title");
                String duration = resultSet.getString("duration");
                songList.addItem(title);
                songDurations.put(title, duration); // Store the duration of the song in the map
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
            JOptionPane.showMessageDialog(this, "Error occurred while loading song titles!");
        }
    }

    public static void main(String[] args) {
        SwingUtilities.invokeLater(new Runnable() {
            @Override
            public void run() {
                PlaylistManager playlistManager = new PlaylistManager();
                playlistManager.setVisible(true);
            }
        });
    }
}