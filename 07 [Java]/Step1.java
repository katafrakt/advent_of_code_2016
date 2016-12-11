import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.io.File;
import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.io.FileNotFoundException;
import java.util.ArrayList;
import java.util.List;

public class Step1 {
    public static void main(String [] args)  throws FileNotFoundException, IOException {
        Step1 step = new Step1();
        System.out.println(step.run());
    }

    public int run() throws FileNotFoundException, IOException {
        File file = new File("./input.txt");
        BufferedReader reader = new BufferedReader(new FileReader(file));
        String line = null;
        int correctIPs = 0;

        while ((line = reader.readLine()) != null) {
            List<String> sequences = new ArrayList<String>();
            Matcher m = Pattern.compile("\\[[a-z]+\\]").matcher(line);
            boolean hasSequenceMatch = false;

            while (m.find()) {
                sequences.add(m.group());
            }

            for (String sequence : sequences) {
                if (this.hasABBA(sequence)) {
                    hasSequenceMatch = true;
                    break;
                }
            }

            if (hasSequenceMatch) continue;

            String[] parts = line.split("\\[[a-z]+\\]");

            for (String part : parts) {
                if (this.hasABBA(part)) {
                    correctIPs++;
                    break;
                }
            }
        }

        return correctIPs;
    }

    private boolean hasABBA(String string) {
        for (int i = 0; i < string.length() - 3; i++) {
            if (string.charAt(i) == string.charAt(i + 3) && string.charAt(i+1) == string.charAt(i+2) && string.charAt(i) != string.charAt(i+1)) {
                return true;
            }
        }
        return false;
    }
}