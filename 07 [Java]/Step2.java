import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.io.File;
import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.io.FileNotFoundException;
import java.util.ArrayList;
import java.util.List;

public class Step2 {
    public static void main(String [] args)  throws FileNotFoundException, IOException {
        Step2 step = new Step2();
        System.out.println(step.run());
    }

    public int run() throws FileNotFoundException, IOException {
        File file = new File("./input.txt");
        BufferedReader reader = new BufferedReader(new FileReader(file));
        String line = null;
        int correctIPs = 0;

        while ((line = reader.readLine()) != null) {
            List<String> sequences = new ArrayList<String>();

            String[] parts = line.split("\\[[a-z]+\\]");

            List<String> ABAs = new ArrayList<String>();

            for (String part : parts) {
                List<String> abas = this.getABAs(part);
                for (String s : abas)
                    ABAs.add(s);
            }

            for (String aba : ABAs) {
                char[] reverseAba = {aba.charAt(1), aba.charAt(0), aba.charAt(1)};
                String revStr = new String(reverseAba);
                Matcher m = Pattern.compile("\\[[a-z]*" + revStr + "[a-z]*\\]").matcher(line);

                if (m.find()) {
                    correctIPs++;
                    break;
                }
            }
        }

        return correctIPs;
    }

    private List<String> getABAs(String string) {
        List<String> result = new ArrayList<String>();
        for (int i = 0; i < string.length() - 2; i++) {
            if (string.charAt(i) == string.charAt(i + 2) && string.charAt(i) != string.charAt(i+1)) {
                result.add(string.substring(i, i+3));
            }
        }
        return result;
    }
}