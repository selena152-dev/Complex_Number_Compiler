// Membre 1 : Thirizi AROUR (22 41 43 14)
// Membre 2 : Lucas BATTAGLIA (22 10 22 15)
// GitLab (ISIMA) du projet : https://gitlab.isima.fr/cours-l3-info1/projet-compilation.git

grammar Complexe;

@parser::members {
    private int precision = 10;

    public class Variable {
        private final String type; // Type de la variable
        private final int adresse; // Adresse du premier mot de la variable

        // Constructeur pour initialiser une variable
        public Variable(String type, int adresse) {
            this.type = type;
            this.adresse = adresse;
        }

        // Getter pour le type
        public String getType() {
            return this.type;
        }

        // Getter pour l'adresse
        public int getAdresse() {
            return this.adresse;
        }
    }

	// Table des symboles pour stocker les noms des variables, leurs types et adresses
	private java.util.Map<String, Variable> symbolTable = new java.util.HashMap<>();
	private int lastAdressVariable = 0;

	private int label = 0;
	 // Méthode pour gérer les instructions "break" et "continue" dans les boucles
     private String handleBreaksAndContinues(String code, int loopLabel) {
        // Remplacer "break" par l'instruction JUMP appropriée
        code = code.replace("break;", "JUMP lab" + (loopLabel - 2) + "\n");
        // Remplacer "continue" par l'instruction JUMP appropriée
        code = code.replace("continue;", "JUMP lab" + (loopLabel - 3) + "\n");
        code = code.replace("error;", "JUMP lab" + (loopLabel - 1) + "\n");
        return code;
    }
}


// Début de la grammaire
start
    : programme EOF {
    String suprVariable = "";                                                   // Pour supprimer les variables declarer avant le halt (vider la memoire)
    for (int i = 0; i < lastAdressVariable; i++) {
        suprVariable += "POP\n";
    }

    // liberation des variables + HALT + fonction MVAP que nous utilisont plus loins dans le programme.
    // On les definis ici pour eviter d'avoir a les definir a chaque fois qu'on les appelle (mvap beaucoup trop grand),
    // ou d'utiliser un patron singleton
    System.out.println(suprVariable + "HALT\n\n\n\n"
        + "LABEL cos\n"+                                                        // fonction cosinus sur un flotant dans la memoire, on enregistre le resultat sur un flotant dans un espace reserver avant l'argument
        "   PUSHF 1.0\n"+
        "   STOREL -5\n"+
        "   STOREL -6\n"+
        "   PUSHI 2\n"+
        "   LABEL cond_cos\n"+
        "       PUSHL 0\n"+
        "       PUSHI " + (2*precision) + "\n"+
        "       NEQ\n"+
        "       JUMPF retour_cos\n"+
        "   PUSHL 0\n"+
        "   PUSHI 2\n"+
        "   DIV\n"+
        "   PUSHI 2\n"+
        "   MOD\n"+
        "   PUSHI 0\n"+
        "   NEQ\n"+
        "   JUMPF plus_cos\n"+
        "   PUSHL -6\n"+
        "   PUSHL -5\n"+
        "   PUSHF 0.0\n"+
        "   PUSHL -4\n"+
        "   PUSHL -3\n"+
        "   PUSHL 0\n"+
        "   ITOF\n"+
        "   CALL pow\n"+
        "   CALL fact\n"+
        "   FTOI\n"+
        "   PUSHI 2\n"+
        "   ADD\n"+
        "   STOREL 0\n"+
        "   FDIV\n"+
        "   FSUB\n"+
        "   STOREL -5\n"+
        "   STOREL -6\n"+
        "   JUMP cond_cos\n"+
        "   LABEL plus_cos\n"+
        "       PUSHL -6\n"+
        "       PUSHL -5\n"+
        "       PUSHF 0.0\n"+
        "       PUSHL -4\n"+
        "       PUSHL -3\n"+
        "       PUSHL 0\n"+
        "       ITOF\n"+
        "       CALL pow\n"+
        "       CALL fact\n"+
        "       FTOI\n"+
        "       PUSHI 2\n"+
        "       ADD\n"+
        "       STOREL 0\n"+
        "       FDIV\n"+
        "       FADD\n"+
        "       STOREL -5\n"+
        "       STOREL -6\n"+
        "       JUMP cond_cos\n"+
        "   LABEL retour_cos\n"+
        "       RETURN\n"+


        "LABEL sin\n"+                                                       // fonction sinus sur un flotant dans la memoire, on enregistre le resultat sur un flotant dans un espace reserver avant l'argument
        "   PUSHL -4\n"+
        "   PUSHL -3\n"+
        "   STOREL -5\n"+
        "   STOREL -6\n"+
        "   PUSHI 3\n"+
        "   LABEL cond_sin\n"+
        "       PUSHL 0\n"+
        "       PUSHI " + (2*precision + 1) + "\n"+
        "       NEQ\n"+
        "       JUMPF retour_sin\n"+
        "   PUSHL 0\n"+
        "   PUSHI 1\n"+
        "   SUB\n"+
        "   PUSHI 2\n"+
        "   DIV\n"+
        "   PUSHI 2\n"+
        "   MOD\n"+
        "   PUSHI 0\n"+
        "   NEQ\n"+
        "   JUMPF plus_sin\n"+
        "   PUSHL -6\n"+
        "   PUSHL -5\n"+
        "   PUSHF 0.0\n"+
        "   PUSHL -4\n"+
        "   PUSHL -3\n"+
        "   PUSHL 0\n"+
        "   ITOF\n"+
        "   CALL pow\n"+
        "   CALL fact\n"+
        "   FTOI\n"+
        "   PUSHI 2\n"+
        "   ADD\n"+
        "   STOREL 0\n"+
        "   FDIV\n"+
        "   FSUB\n"+
        "   STOREL -5\n"+
        "   STOREL -6\n"+
        "   JUMP cond_sin\n"+
        "   LABEL plus_sin\n"+
        "       PUSHL -6\n"+
        "       PUSHL -5\n"+
        "       PUSHF 0.0\n"+
        "       PUSHL -4\n"+
        "       PUSHL -3\n"+
        "       PUSHL 0\n"+
        "       ITOF\n"+
        "       CALL pow\n"+
        "       CALL fact\n"+
        "       FTOI\n"+
        "       PUSHI 2\n"+
        "       ADD\n"+
        "       STOREL 0\n"+
        "       FDIV\n"+
        "       FADD\n"+
        "       STOREL -5\n"+
        "       STOREL -6\n"+
        "       JUMP cond_sin\n"+
        "   LABEL retour_sin\n"+
        "       RETURN\n"+


        "LABEL sqrt\n"+                                              // fonction racine carre sur un flotant dans la memoire, on enregistre le resultat sur un flotant dans un espace reserver avant l'argument
        "   PUSHF 1.0\n"+
        "   STOREL -5\n"+
        "   STOREL -6\n"+
        "   PUSHI 0\n"+
        "   LABEL cond_sqrt\n"+
        "       PUSHL 0\n"+
        "       PUSHI " + (2*precision) + "\n"+
        "       NEQ\n"+
        "       JUMPF retour_sqrt\n"+
        "   PUSHF 1.0\n"+
        "   PUSHF 2.0\n"+
        "   FDIV\n"+
        "   PUSHL -6\n"+
        "   PUSHL -5\n"+
        "   PUSHL -4\n"+
        "   PUSHL -3\n"+
        "   PUSHL -6\n"+
        "   PUSHL -5\n"+
        "   FDIV\n"+
        "   FADD\n"+
        "   FMUL\n"+
        "   STOREL -5\n"+
        "   STOREL -6\n"+
        "   PUSHL 0\n"+
        "   PUSHI 1\n"+
        "   ADD\n"+
        "   STOREL 0\n"+
        "   JUMP cond_sqrt\n"+
        "   LABEL retour_sqrt\n"+
        "       RETURN\n"+


        "LABEL pow\n"+                                                      // fonction puissance sur un flotant dans la memoire suivie d'une puissance (flottante mais gerer comme un entier), on enregistre sur un flotant dans un espace reserver avant les arguments
        "   PUSHL -6\n"+
        "   PUSHL -5\n"+
        "   STOREL -7\n"+
        "   STOREL -8\n"+
        "   PUSHF 1.0\n"+
        "   LABEL cond_pow\n"+
        "       PUSHL 0\n"+
        "       PUSHL 1\n"+
        "       PUSHL -4\n"+
        "       PUSHL -3\n"+
        "       FNEQ\n"+
        "       JUMPF retour_pow\n"+
        "   PUSHL -6\n"+
        "   PUSHL -5\n"+
        "   PUSHL -8\n"+
        "   PUSHL -7\n"+
        "   FMUL\n"+
        "   STOREL -7\n"+
        "   STOREL -8\n"+
        "   PUSHF 1.0\n"+
        "   PUSHL 0\n"+
        "   PUSHL 1\n"+
        "   FADD\n"+
        "   STOREL 1\n"+
        "   STOREL 0\n"+
        "   JUMP cond_pow\n"+
        "   LABEL retour_pow\n"+
        "       RETURN\n"+


        "LABEL fact\n"+                                                         // fonction factoriel sur un flotant dans la memoire, on enregistre le resultat sur un flotant dans un espace reserver avant l'argument
        "   PUSHL -4\n"+
        "   PUSHL -3\n"+
        "   STOREL -5\n"+
        "   STOREL -6\n"+
        "   PUSHL -4\n"+
        "   PUSHL -3\n"+
        "   LABEL cond_fact\n"+
        "       PUSHL 0\n"+
        "       PUSHL 1\n"+
        "       PUSHF 1.0\n"+
        "       FNEQ\n"+
        "       JUMPF retour_fact\n"+
        "   PUSHL 0\n"+
        "   PUSHL 1\n"+
        "   PUSHF 1.0\n"+
        "   FSUB\n"+
        "   STOREL 1\n"+
        "   STOREL 0\n"+
        "   PUSHL 0\n"+
        "   PUSHL 1\n"+
        "   PUSHL -6\n"+
        "   PUSHL -5\n"+
        "   FMUL\n"+
        "   STOREL -5\n"+
        "   STOREL -6\n"+
        "   JUMP cond_fact\n"+
        "   LABEL retour_fact\n"+
        "       RETURN\n"+


        "LABEL reel\n"+                                                         // fonction recuperent la partie reel sur un complexe (4 mots) dans la memoire, on enregistre le resultat sur un flotant dans un espace reserver avant l'argument
        "   PUSHL -6\n"+
        "   PUSHL -5\n"+
        "   STOREL -7\n"+
        "   STOREL -8\n"+
        "   RETURN\n"+


        "LABEL im\n"+                                                           // fonction recuperent la partie imaginaire sur un complexe (4 mots) dans la memoire, on enregistre le resultat sur un flotant dans un espace reserver avant l'argument
        "   PUSHL -4\n"+
        "   PUSHL -3\n"+
        "   STOREL -7\n"+
        "   STOREL -8\n"+
        "   RETURN\n"+


        "LABEL evaluateConditional\n" +                                         // fonction permetant d'enregistrer le complexe correspondant a la valeur du booleen dans la memoire, on enregistre le resultat sur un flotant dans un espace reserver avant les arguments. L'ordre des arguments est booleen, complexe si vrai, complexe si faux
        "    PUSHL -11\n" +
        "    JUMPF eval_false\n" +
        "    PUSHL -10\n" +
        "    PUSHL -9\n" +
        "    PUSHL -8\n" +
        "    PUSHL -7\n" +
        "    JUMP eval_end\n" +
        "    LABEL eval_false\n" +
        "        PUSHL -6\n" +
        "        PUSHL -5\n" +
        "        PUSHL -4\n" +
        "        PUSHL -3\n" +
        "    LABEL eval_end\n" +
        "    STOREL -12\n" +
        "    STOREL -13\n" +
        "    STOREL -14\n" +
        "    STOREL -15\n" +
        "    RETURN\n"+


        "LABEL puissance\n"+                                                    // fonction puissance sur un complexe (4 mots) suivis de la puissance (entiere positive ou negative ou nulle) dans la memoire, on enregistre le resultat sur un flotant dans un espace reserver avant les arguments
        "    PUSHL -3\n"+
        "    PUSHI 0\n"+
        "    INF\n"+
        "    JUMPF positif_puissance\n"+
        "    PUSHI 0\n"+
        "    PUSHL -7\n"+
        "    PUSHL -6\n"+
        "    PUSHL -7\n"+
        "    PUSHL -6\n"+
        "    PUSHL -7\n"+
        "    PUSHL -6\n"+
        "    FMUL\n"+
        "    PUSHL -5\n"+
        "    PUSHL -4\n"+
        "    PUSHL -5\n"+
        "    PUSHL -4\n"+
        "    FMUL\n"+
        "    FADD\n"+
        "    FDIV\n"+
        "    PUSHF 0.0\n"+
        "    PUSHL -5\n"+
        "    PUSHL -4\n"+
        "    PUSHL -7\n"+
        "    PUSHL -6\n"+
        "    PUSHL -7\n"+
        "    PUSHL -6\n"+
        "    FMUL\n"+
        "    PUSHL -5\n"+
        "    PUSHL -4\n"+
        "    PUSHL -5\n"+
        "    PUSHL -4\n"+
        "    FMUL\n"+
        "    FADD\n"+
        "    FDIV\n"+
        "    FSUB\n"+
        "    STOREL -8\n"+
        "    STOREL -9\n"+
        "    STOREL -10\n"+
        "    STOREL -11\n"+
        "    PUSHL -11\n"+
        "    PUSHL -10\n"+
        "    PUSHL -9\n"+
        "    PUSHL -8\n"+
        "    PUSHI 1\n"+
        "    STOREL 0\n"+
        "    PUSHI 0\n"+
        "    PUSHL -3\n"+
        "    SUB\n"+
        "    STOREL -3\n"+
        "    LABEL cond_neg_puissance\n"+
        "        PUSHL 0\n"+
        "        PUSHL -3\n"+
        "        NEQ\n"+
        "        JUMPF retour_puissance\n"+
        "    PUSHL -11\n"+
        "    PUSHL -10\n"+
        "    PUSHL 1\n"+
        "    PUSHL 2\n"+
        "    FMUL\n"+
        "    PUSHL -9\n"+
        "    PUSHL -8\n"+
        "    PUSHL 3\n"+
        "    PUSHL 4\n"+
        "    FMUL\n"+
        "    FSUB\n"+
        "    PUSHL -11\n"+
        "    PUSHL -10\n"+
        "    PUSHL 3\n"+
        "    PUSHL 4\n"+
        "    FMUL\n"+
        "    PUSHL -9\n"+
        "    PUSHL -8\n"+
        "    PUSHL 1\n"+
        "    PUSHL 2\n"+
        "    FMUL\n"+
        "    FADD\n"+
        "    STOREL -8\n"+
        "    STOREL -9\n"+
        "    STOREL -10\n"+
        "    STOREL -11\n"+
        "    PUSHL 0\n"+
        "    PUSHI 1\n"+
        "    ADD\n"+
        "    STOREL 0\n"+
        "    JUMP cond_neg_puissance\n"+
        "    LABEL positif_puissance\n"+
        "    PUSHF 1.0\n"+
        "    PUSHF 0.0\n"+
        "    STOREL -8\n"+
        "    STOREL -9\n"+
        "    STOREL -10\n"+
        "    STOREL -11\n"+
        "    PUSHI 0\n"+
        "    LABEL cond_puissance\n"+
        "        PUSHL 0\n"+
        "        PUSHL -3\n"+
        "        NEQ\n"+
        "        JUMPF retour_puissance\n"+
        "    PUSHL -7\n"+
        "    PUSHL -6\n"+
        "    PUSHL -11\n"+
        "    PUSHL -10\n"+
        "    FMUL\n"+
        "    PUSHL -5\n"+
        "    PUSHL -4\n"+
        "    PUSHL -9\n"+
        "    PUSHL -8\n"+
        "    FMUL\n"+
        "    FSUB\n"+
        "    PUSHL -7\n"+
        "    PUSHL -6\n"+
        "    PUSHL -9\n"+
        "    PUSHL -8\n"+
        "    FMUL\n"+
        "    PUSHL -5\n"+
        "    PUSHL -4\n"+
        "    PUSHL -11\n"+
        "    PUSHL -10\n"+
        "    FMUL\n"+
        "    FADD\n"+
        "    STOREL -8\n"+
        "    STOREL -9\n"+
        "    STOREL -10\n"+
        "    STOREL -11\n"+
        "    PUSHL 0\n"+
        "    PUSHI 1\n"+
        "    ADD\n"+
        "    STOREL 0\n"+
        "    JUMP cond_puissance\n"+
        "    LABEL retour_puissance\n"+
        "        RETURN\n"
        );
    };


// L'ordre des diferentes regle qui doivent apparaitre dans le programme
programme returns [String code]
        @init{ $code = new String(); }                                                                      // On initialise $code, pour ensuite l’utiliser comme accumulateur
        @after{
            $code = $code.replace("error;", "");                                                            // on supprime les "error;" ecrit en trop
            System.out.println($code);                                                                      // on affiche le code MVaP stocké dans code
        }
	: NEWLINE* (declaration END {$code += $declaration.code;})* NEWLINE* ((fonction {$code += $fonction.code;} | assignment {$code += $assignment.code;}) END)*
	;


// Les declaration de variable
declaration returns [String code]
    : TYPE IDENTIFIANT {
        if (symbolTable.containsKey($IDENTIFIANT.text)) {                                                   // si la variable a deja etait declarer
            System.err.println("Erreur : variable déjà déclarée " + $IDENTIFIANT.text);                     // message d'erreur
            $code = "error;";                                                                               // Pour eviter d'avoir un null dans le code mvap + gestion du sinon dans les boucles repeter
        } else {
            if ($TYPE.text.equals("Complexe")) {
                $code = "PUSHF 0.0\nPUSHF 0.0\n";                                                           // on reserve de la memoire dans la pile
                symbolTable.put($IDENTIFIANT.text, new Variable($TYPE.text, lastAdressVariable));           // On enregistre dans la map les information sur la variable
                lastAdressVariable += 4;                                                                    // on incremente l'adresse du premier mots de la prochaine variable de 1 (pour ne pas ecraser la variable actuelle)
            } else if ($TYPE.text.equals("Booleen")) {
                $code = "PUSHI 0\n" ;                                                                       // On reserve de la memoire dans la pile
                symbolTable.put($IDENTIFIANT.text, new Variable($TYPE.text, lastAdressVariable));           // On enregistre dans la map les information sur la variable
                lastAdressVariable += 1;                                                                    // on incremente l'adresse du premier mots de la prochaine variable de 1 (pour ne pas ecraser la variable actuelle)
            } else {
                System.err.println("Erreur : Le type " + $TYPE.text + " n'existe pas !");                   // message d'erreur
                $code = "error;";                                                                           // Pour eviter d'avoir un null dans le code mvap + gestion du sinon dans les boucles repeter
            }
        }
    }
    ;


// Assignement d'une valeur a une variable
assignment returns [String code]
    : IDENTIFIANT '=' c=complexe {
        if (!symbolTable.containsKey($IDENTIFIANT.text)) {                                                  // Si la variable n'a pas etait declarer
            System.err.println("Erreur : La variable " + $IDENTIFIANT.text + " n'a pas été déclarée ");     // message d'erreur
            $code = "error;";                                                                               // Pour eviter d'avoir un null dans le code mvap + gestion du sinon dans les boucles repeter
        } else {
            if (symbolTable.get($IDENTIFIANT.text).getType().equals("Complexe")) {
                int firstWord = symbolTable.get($IDENTIFIANT.text).getAdresse();                            // Adresse du premiere mots associer a la variable
                $code = $c.code +                                                                           // On enregistre le complexe dans la memoire sur les mots associer a la variable
                        "STOREG " + (firstWord + 3) + "\n" +
                        "STOREG " + (firstWord + 2) + "\n" +
                        "STOREG " + (firstWord + 1) + "\n" +
                        "STOREG " + (firstWord + 0) + "\n";
            } else {
                System.err.println("Erreur : La variable " + $IDENTIFIANT.text + " est de type " + symbolTable.get($IDENTIFIANT.text).getType() + " et non pas Complexe");  // message d'erreur
                $code = "error;";                                                                           // Pour eviter d'avoir un null dans le code mvap + gestion du sinon dans les boucles repeter
            }
        }
    }

    | IDENTIFIANT '=' a=arithmetic {
        if (!symbolTable.containsKey($IDENTIFIANT.text)) {                                                  // Si la variable n'a pas etait declarer
            System.err.println("Erreur : La variable " + $IDENTIFIANT.text + " n'a pas été déclarée ");     // message d'erreur
            $code = "error;";                                                                               // Pour eviter d'avoir un null dans le code mvap + gestion du sinon dans les boucles repeter
        } else {
            if (symbolTable.get($IDENTIFIANT.text).getType().equals("Complexe")) {
                int firstWord = symbolTable.get($IDENTIFIANT.text).getAdresse();                            // Adresse du premiere mots associer a la variable
                $code = $a.code +                                                                           // On enregistre le complexe dans la memoire sur les mots associer a la variable
                        "STOREG " + (firstWord + 3) + "\n" +
                        "STOREG " + (firstWord + 2) + "\n" +
                        "STOREG " + (firstWord + 1) + "\n" +
                        "STOREG " + (firstWord + 0) + "\n";
            } else {
                System.err.println("Erreur : La variable " + $IDENTIFIANT.text + " est de type " + symbolTable.get($IDENTIFIANT.text).getType() + " et non pas Complexe");  // message d'erreur
                $code = "error;";                                                                           // Pour eviter d'avoir un null dans le code mvap + gestion du sinon dans les boucles repeter
            }
        }
    }

    | IDENTIFIANT '=' b=bool {
        if (!symbolTable.containsKey($IDENTIFIANT.text)) {                                                  // Si la variable n'a pas etait declarer
            System.err.println("Erreur : La variable " + $IDENTIFIANT.text + " n'a pas était déclarée ");   // message d'erreur
            $code = "error;";                                                                               // Pour eviter d'avoir un null dans le code mvap + gestion du sinon dans les boucles repeter
        } else {
            if (symbolTable.get($IDENTIFIANT.text).getType().equals("Booleen")) {
                int firstWord = symbolTable.get($IDENTIFIANT.text).getAdresse();                            // Adresse du premiere mots associer a la variable
                $code = $b.code + "STOREG " + firstWord + "\n";                                             // On enregistre le booleen dans la memoire sur le mot associer a la variable
            } else {
                System.err.println("Erreur : La variable " + $IDENTIFIANT.text + " est de type " + symbolTable.get($IDENTIFIANT.text).getType() + " et non pas Booleen");   // message d'erreur
                $code = "error;";                                                                           // Pour eviter d'avoir un null dans le code mvap + gestion du sinon dans les boucles repeter
            }
        }
    }
    ;


// Definition d'un bloc d'instruction
instr returns [String code]
    : {$code = "";} NEWLINE* '{' NEWLINE* ((assignment {$code += $assignment.code;} | fonction {$code += $fonction.code;} | breakStatement {$code += $breakStatement.code;} | continueStatement {$code += $continueStatement.code;}) END)* '}'
    ;


// Definition du mots cle Break
breakStatement returns [String code]
    : 'break' {
        // Pas besoin de générer une instruction JUMP ici ; elle sera gérée par handleBreaksAndContinues
        $code = "break;";
    }
    ;


// Definition du mots cle Continue
continueStatement returns [String code]
    : 'continue' {
           // Pas besoin de générer une instruction JUMP ici ; elle sera gérée par handleBreaksAndContinues
        $code = "continue;";
    }
    ;


// Definition des differente fonctionne accepter par notre language
fonction returns [String code]
    : 'afficher(' IDENTIFIANT ')' {
        if (!symbolTable.containsKey($IDENTIFIANT.text)) {													// Si la variable n'a pas etait declarer
            System.err.println("Erreur : La variable " + $IDENTIFIANT.text + " n'a pas était déclarée ");	// message d'erreur
            $code = "error;";																				// Pour eviter d'avoir un null dans le code mvap + gestion du sinon dans les boucles repeter
        } else {
            if (symbolTable.get($IDENTIFIANT.text).getType().equals("Complexe")) {							//  si la variable est de type complexe
                int firstWord = symbolTable.get($IDENTIFIANT.text).getAdresse();							// Adresse du premiere mots associer a la variable
                String code = "PUSHG " + (firstWord + 0) + "\nPUSHG " + (firstWord + 1) + "\nPUSHG " + (firstWord + 2) + "\nPUSHG " + (firstWord + 3) + "\n";
                $code = "PUSHF 0.0\n" + code + "CALL reel\nPOP\nPOP\nPOP\nPOP\nWRITEF\nPOP\nPOP\n";			// On enregistre le complexe dans la memoire sur les mots associer a la variable
                $code += "PUSHF 0.0\n" + code + "CALL im\nPOP\nPOP\nPOP\nPOP\nWRITEF\nPOP\nPOP\n";
            } else if (symbolTable.get($IDENTIFIANT.text).getType().equals("Booleen")) {					//  si la variable est de type booleen
                int firstWord = symbolTable.get($IDENTIFIANT.text).getAdresse();							// Adresse du premiere mots associer a la variable
                String code = "PUSHG " + firstWord + "\n";
                $code = code + "\nWRITE\nPOP\n";															// On enregistre le booleen dans la memoire sur le mot associer a la variable
            }
        }
    }

    | 'afficher(' complexe ')' {																			 // Fonction pour afficher un nombre complexe
        $code = "PUSHF 0.0\n" + $complexe.code + "CALL reel\nPOP\nPOP\nPOP\nPOP\nWRITEF\nPOP\nPOP\n";		 // Génère le code MVaP pour afficher la partie réelle du complexe
        $code += "PUSHF 0.0\n" + $complexe.code + "CALL im\nPOP\nPOP\nPOP\nPOP\nWRITEF\nPOP\nPOP\n";		 // Génère le code MVaP pour afficher la partie imaginaire du complexe
    }

    | 'afficher(' arithmetic ')' {																			// Fonction pour afficher le résultat d'une expression arithmétique
    	$code = "PUSHF 0.0\n" + $arithmetic.code + "CALL reel\nPOP\nPOP\nPOP\nPOP\nWRITEF\nPOP\nPOP\n";		// Génère le code MVaP pour afficher la partie réelle du résultat de l'expression arithmétiqe
    	$code += "PUSHF 0.0\n" + $arithmetic.code + "CALL im\nPOP\nPOP\nPOP\nPOP\nWRITEF\nPOP\nPOP\n";		// Génère le code MVaP pour afficher la partie imaginaire du résultat de l'expression arithmétique
    }

    | 'afficher(' bool ')' {																				// Fonction pour afficher un booléen
        $code = $bool.code + "\nWRITE\nPOP\n";																// Génère le code MVaP pour afficher la valeur du booléen
    }

    | 'lire(' IDENTIFIANT ')' {
        if (!symbolTable.containsKey($IDENTIFIANT.text)) {													// Si la variable n'a pas etait declarer
            System.err.println("Erreur : La variable " + $IDENTIFIANT.text + " n'a pas été déclarée");		// message d'erreur
            $code = "error;";																				// Pour eviter d'avoir un null dans le code mvap + gestion du sinon dans les boucles repeter
        } else {
            if (symbolTable.get($IDENTIFIANT.text).getType().equals("Complexe")) {							//  si la variable est de type complexe
                int firstWord = symbolTable.get($IDENTIFIANT.text).getAdresse();							// Adresse du premiere mots associer a la variable

                $code = "READF\n" +																			// Génère le code MVaP pour lire et stocker la partie réelle
                       "STOREG " + (firstWord + 1) + "\n" +
                       "STOREG " + (firstWord + 0) + "\n" +

                       "READF\n" +																			// Génère le code MVaP pour lire et stocker la partie imaginaire
                       "STOREG " + (firstWord + 3) + "\n" +
                       "STOREG " + (firstWord + 2) + "\n";
            } else if (symbolTable.get($IDENTIFIANT.text).getType().equals("Booleen")) {					//  si la variable est de type booleen
                int firstWord = symbolTable.get($IDENTIFIANT.text).getAdresse();							// Adresse du premiere mots associer a la variable
                // Read boolean (0 or 1)
                $code = "READ\n" +
                       "STOREG " + firstWord + "\n";
            } else {
                System.err.println("Erreur : Type non reconnu pour la lecture");							 // Si le type de la variable n'est pas reconnu, affiche une erreur
                $code = "error;";																			// Pour eviter d'avoir un null dans le code mvap + gestion du sinon dans les boucles repeter
            }
        }
    }

    | bool '?' a1=arithmetic ':' a2=arithmetic {						 									// Fonction pour évaluer une expression conditionnelle
        $code = "PUSHF 0.0\nPUSHF 0.0\n" + $bool.code + $a1.code + $a2.code + "CALL evaluateConditional\nPOP\nPOP\nPOP\nPOP\nPOP\nPOP\nPOP\nPOP\nPOP\n";
    }

    | 'lorsque (' b=bool ') faire' i1=instr {																// Structure de contrôle "lorsque" (équivalent à "if")
        label = label + 1;
        $code = $b.code + "JUMPF lab" + (label - 1) + "\n" +
                $i1.code + "JUMP lab" + (label - 1) + "\n" +
                "LABEL lab" + (label - 1) + "\n";
    }

    | 'lorsque (' b=bool ') faire' i1=instr NEWLINE? 'autrement' i2=instr {									// Structure de contrôle "lorsque...autrement" (équivalent à "if...else")
        label = label + 2;																					// Incrémente le compteur de labels pour créer des identifiants uniques
        $code = $b.code + "JUMPF lab" + (label - 2) + "\n" +
                $i1.code + "JUMP lab" + (label - 1) + "\n" +
                "LABEL lab" + (label - 2) + "\n" + $i2.code + "JUMP lab" + (label - 1) + "\n" +
                "LABEL lab" + (label - 1) + "\n";
    }

    | 'repeter' i1=instr 'jusque (' b=bool ')' NEWLINE? 'sinon' i2=instr {									// Structure de contrôle "repeter...jusque...sinon"
        // Crée une étiquette locale pour cette boucle
        int loopLabel = label + 5;
        label = loopLabel;
        $code = "LABEL lab" + (loopLabel - 3) + "\n" +														// Génère le code MVaP pour la boucle et la condition
                handleBreaksAndContinues($i1.code, loopLabel) +												// Gère les "break" et "continue" dans la boucle
                $b.code +
                "JUMPF lab" + (loopLabel - 3) + "\n" +
                "JUMP lab" + (loopLabel - 2) + "\n" +
                "LABEL lab" + (loopLabel - 1) + "\n" +
                handleBreaksAndContinues($i2.code, loopLabel) +
                "JUMP lab" + (loopLabel - 2) + "\n" +
                "LABEL lab" + (loopLabel - 2) + "\n";
    }
    ;


// Représentation des flottants (tout ce qui renvois un flottant)
flotant returns [String code]
	: num1=ENTIER '.' num2=ENTIER {																			// Cas d'un nombre flottant avec une partie entière et une partie décimale (ex: 3.14) 
    	$code = "PUSHF " + $num1.text + "." + $num2.text + "\n";											// Génère le code MVaP pour empiler un flottant (ex: PUSHF 3.14)
	}

	| '.' num2=ENTIER {																						// Cas d'un nombre flottant sans partie entière (ex: .14)
    	$code = "PUSHF 0." + $num2.text + "\n";
	}

	| ENTIER {																								// Cas d'un entier (ex: 42)
    	$code = "PUSHF " + $ENTIER.text + ".0\n";
	}

	| 'reel' '(' expr=arithmetic ')' {																		// Cas où on extrait la partie réelle d'une expression arithmétique
    	$code = "PUSHF 0.0\n" + $expr.code + "CALL reel\nPOP\nPOP\nPOP\nPOP\n";
	}

	| 'im' '(' expr=arithmetic ')' {																		// Cas où on extrait la partie imaginaire d'une expression arithmétique
    	$code = "PUSHF 0.0\n" + $expr.code + "CALL im\nPOP\nPOP\nPOP\nPOP\n";
	}
	;


// Representation des Complexes
complexe returns [String code]
    : IDENTIFIANT {
        if (symbolTable.containsKey($IDENTIFIANT.text) && symbolTable.get($IDENTIFIANT.text).getType().equals("Complexe")) {      //  si la variable est de type complexe
            int firstWord = symbolTable.get($IDENTIFIANT.text).getAdresse();													  // Adresse du premiere mots associer a la variable
            $code = "PUSHG " + (firstWord + 0) + "\n" +  // Load real part
                    "PUSHG " + (firstWord + 1) + "\n" +
                    "PUSHG " + (firstWord + 2) + "\n" +
                    "PUSHG " + (firstWord + 3) + "\n";   // Load imaginary part
        } else {
            System.err.println("Erreur : La variable " + $IDENTIFIANT.text + " n'est pas déclarée comme Complexe");     // message d'erreur
            $code = "error;";																  			 // Pour eviter d'avoir un null dans le code mvap + gestion du sinon dans les boucles repeter
        }
    }

	| a=flotant '+i' b=flotant {																		// Cas d'un nombre complexe sous la forme a + ib (ex: 3.0 + i4.0)
    	$code = $a.code + $b.code;
	}

	|a=flotant '-i' b=flotant {																			// Cas d'un nombre complexe sous la forme a - ib (ex: 3.0 - i4.0)
    	$code = $a.code + "PUSHF 0.0\n" + $b.code + "FSUB\n";
	}

	|'-' a=flotant '-i' b=flotant {																		// Cas d'un nombre complexe sous la forme -a - ib (ex: -3.0 - i4.0)
    	$code = "PUSHF 0.0\n" + $a.code + "FSUB\nPUSHF 0.0\n" + $b.code + "FSUB\n";
	}

	|'-' a=flotant '+i' b=flotant {																		// Cas d'un nombre complexe sous la forme -a + ib (ex: -3.0 + i4.0)
    	$code = "PUSHF 0.0\n" + $a.code + "FSUB\n" + $b.code;
	}

	| a=flotant {																						// Cas d'un nombre réel (partie imaginaire nulle, ex: 3.0)
    	$code = $a.code + "PUSHF 0.0\n";
	}

	| '-' a=flotant {																				    // Cas d'un nombre réel négatif (partie imaginaire nulle, ex: -3.0)
        $code = "PUSHF 0.0\n" + $a.code + "FSUB\nPUSHF 0.0\n";
    }

	| 'i' f=flotant {																					// Cas d'un nombre imaginaire pur positif (ex: i2.0)
    	$code = "PUSHF 0.0\n" + $f.code;
	}

	| '-i' f=flotant {																					// Cas d'un nombre imaginaire pur négatif (ex: -i2.0)
    	$code = "PUSHF 0.0\nPUSHF 0.0\n" + $f.code + "FSUB\n";
	}

	| 'i' {																								 // Cas d'un nombre imaginaire pur positif (ex: i)
	    $code = "PUSHF 0.0\nPUSHF 1.0\n";
	}

	| '-i' {																							 // Cas d'un nombre imaginaire pur négatif (ex: -i)
	    $code = "PUSHF 0.0\nPUSHF 0.0\nPUSHF 1.0\nFSUB\n";
	}

	| r=flotant ':' t=flotant {																			// Cas d'un nombre complexe en coordonnées polaires (ex: 3.0 : 1.57)
    	$code = $r.code + "PUSHF 0.0\n" + $t.code + "CALL cos\nPOP\nPOP\nFMUL\n";
    	$code += $r.code + "PUSHF 0.0\n " + $t.code + "CALL sin\nPOP\nPOP\nFMUL\n";
	}

	| r=flotant 'e^i' t=flotant {																		// Cas d'un nombre complexe en notation exponentielle (ex: 3.0 e^i1.57)
    	$code = $r.code + "PUSHF 0.0\n" + $t.code + "CALL cos\nPOP\nPOP\nFMUL\n";
    	$code += $r.code + "PUSHF 0.0\n " + $t.code + "CALL sin\nPOP\nPOP\nFMUL\n";
	}
	;


// Liste des expressions arithmetique, sur les complexe, acceptercompiler Complexe mvap debug input.txt

arithmetic returns [String code]
    : c=complexe {																						// Cas d'un nombre complexe simple
       $code = $c.code;																					// Retourne directement le code MVaP du complexe
    }

    | '-(' f=arithmetic ')' {																			// Cas d'une expression arithmétique négative
      	$code = "PUSHF 0.0\nPUSHF 0.0\n" + $f.code + "CALL reel\nPOP\nPOP\nPOP\nPOP\nFSUB\n";
        $code = "PUSHF 0.0\nPUSHF 0.0\n" + $f.code + "CALL im\nPOP\nPOP\nPOP\nPOP\nFSUB\n";
    }

    | '(' a=arithmetic ')' {																			// Cas d'une expression arithmétique entre parenthèses
        $code = $a.code;
    }

    | f=arithmetic '**' e=ENTIER {																		// Cas d'une expression élevée à une puissance entière positive
       	$code = "PUSHF 0.0\nPUSHF 0.0\n" + $f.code + "\nPUSHI " + $e.text + "\nCALL puissance\nPOP\nPOP\nPOP\nPOP\nPOP\n";
    }

    | f=arithmetic '**' '-'e=ENTIER {																	// Cas d'une expression élevée à une puissance entière négative
        $code = "PUSHF 0.0\nPUSHF 0.0\n" + $f.code + "\nPUSHI -" + $e.text + "\nCALL puissance\nPOP\nPOP\nPOP\nPOP\nPOP\n";
    }

	| t=arithmetic op=('*' | '/') f=arithmetic {														// Cas d'une multiplication ou division de deux expressions arithmétiques
    	if ($op.text.equals("*")) {
        	$code = "PUSHF 0.0\n" + $t.code + "CALL reel\nPOP\nPOP\n" + $f.code + "CALL reel\nPOP\nPOP\nPOP\nPOP\nFMUL\n";
        	$code += "PUSHF 0.0\n" + $t.code + "CALL im\nPOP\nPOP\n" + $f.code + "CALL im\nPOP\nPOP\nPOP\nPOP\nFMUL\nFSUB\n";
        	$code += "PUSHF 0.0\n" + $t.code + "CALL reel\nPOP\nPOP\n" + $f.code + "CALL im\nPOP\nPOP\nPOP\nPOP\nFMUL\n";
        	$code += "PUSHF 0.0\n" + $t.code + "CALL im\nPOP\nPOP\n" + $f.code + "CALL reel\nPOP\nPOP\nPOP\nPOP\nFMUL\nFADD\n";
    	} else {
        	String den = "PUSHF 0.0\n" + $f.code + "CALL reel\nPOP\nPOP\n" + $f.code + "CALL reel\nPOP\nPOP\nPOP\nPOP\nFMUL\n";
        	den += "PUSHF 0.0\n" + $f.code + "CALL im\nPOP\nPOP\n" + $f.code + "CALL im\nPOP\nPOP\nPOP\nPOP\nFMUL\nFADD\n";
        	$code = "PUSHF 0.0\n" + $t.code + "CALL reel\nPOP\nPOP\n" + $f.code + "CALL reel\nPOP\nPOP\nPOP\nPOP\nFMUL\n";
        	$code += "PUSHF 0.0\n" + $t.code + "CALL im\nPOP\nPOP\n" + $f.code + "CALL im\nPOP\nPOP\nPOP\nPOP\nFMUL\nFADD\n";
        	$code += den + "FDIV\n";
        	$code += "PUSHF 0.0\n" + $t.code + "CALL im\nPOP\nPOP\n" + $f.code + "CALL reel\nPOP\nPOP\nPOP\nPOP\nFMUL\n";
        	$code += "PUSHF 0.0\n" + $t.code + "CALL reel\nPOP\nPOP\n" + $f.code + "CALL im\nPOP\nPOP\nPOP\nPOP\nFMUL\nFSUB\n";
        	$code += den + "FDIV\n";
    	}
	}

    | a=arithmetic op=('+' | '-') t=arithmetic {														// Cas d'une addition ou soustraction de deux expressions arithmétiques
        if ($op.text.equals("+")) {
            // Addition of complex numbers
            $code = "PUSHF 0.0\n" + $a.code + "CALL reel\nPOP\nPOP\n" + $t.code + "CALL reel\nPOP\nPOP\nPOP\nPOP\nFADD\n";
            $code += "PUSHF 0.0\n" + $a.code + "CALL im\nPOP\nPOP\n" + $t.code + "CALL im\nPOP\nPOP\nPOP\nPOP\nFADD\n";
        } else {
            // Subtraction of complex numbers
            $code = "PUSHF 0.0\n" + $a.code + "CALL reel\nPOP\nPOP\n" + $t.code + "CALL reel\nPOP\nPOP\nPOP\nPOP\nFSUB\n";
            $code += "PUSHF 0.0\n" + $a.code + "CALL im\nPOP\nPOP\n" + $t.code + "CALL im\nPOP\nPOP\nPOP\nPOP\nFSUB\n";
        }
    }
    ;


// Representation des booleens
bool returns [String code]
    : IDENTIFIANT {																			// Cas d'une variable booléenne
        if (symbolTable.containsKey($IDENTIFIANT.text) && symbolTable.get($IDENTIFIANT.text).getType().equals("Booleen")) {		 //  si la variable est de type bool	
            int firstWord = symbolTable.get($IDENTIFIANT.text).getAdresse();													 // Adresse du premiere mots associer a la variable
            $code = "PUSHG " + (firstWord + 0) + "\n";																			 // On enregistre le booleen dans la memoire sur le mot associer a la variable
        } else {																												 // Si la variable n'existe pas ou n'est pas de type Booleen, affiche une erreur
            System.err.println("Erreur : La variable " + $IDENTIFIANT.text + " n'est pas déclarée comme Booleen");
            $code = "";																										 	// Retourne un code vide en cas d'erreur
        }
    }
 // Cas d'une expression booléenne entre parenthèses
	| '(' b=bool ')' {
    	$code = $b.code;
	}
// Cas d'une égalité entre deux expressions arithmétiques
	| c1=arithmetic '==' c2=arithmetic {
    	$code = "PUSHF 0.0\n" + $c1.code + "CALL reel\nPOP\nPOP\nPOP\nPOP\nPUSHF 0.0\n" + $c2.code + "CALL reel\nPOP\nPOP\nPOP\nPOP\nFEQUAL\n";			// Compare les parties réelles
    	$code += "PUSHF 0.0\n" + $c1.code + "CALL im\nPOP\nPOP\nPOP\nPOP\nPUSHF 0.0\n" + $c2.code + "CALL im\nPOP\nPOP\nPOP\nPOP\nFEQUAL\n";			// Compare les parties imaginaires
    	$code += "ADD\nPUSHI 2\nEQUAL\n";																						// Vérifie si les deux comparaisons sont vraies
	}
//  Cas d'une égalité entre les normes de deux expressions arithmétiques
	| '|' c1=arithmetic '|' '==' '|' c2=arithmetic '|' {
        String n1 = "PUSHF 0.0\nPUSHF 0.0\nPUSHF 0.0\n" + $c1.code + "CALL reel\nPOP\nPOP\nPOP\nPOP\nPUSHF 2.0\nCALL pow\nPOP\nPOP\nPOP\nPOP\n";		 // Calcule la norme de la première expression arithmétique
        n1 += "PUSHF 0.0\nPUSHF 0.0\n" + $c1.code + "CALL im\nPOP\nPOP\nPOP\nPOP\nPUSHF 2.0\nCALL pow\nPOP\nPOP\nPOP\nPOP\nFADD\n";
        n1 += "CALL sqrt\nPOP\nPOP\n";
        String n2 = "PUSHF 0.0\nPUSHF 0.0\nPUSHF 0.0\n" + $c2.code + "CALL reel\nPOP\nPOP\nPOP\nPOP\nPUSHF 2.0\nCALL pow\nPOP\nPOP\nPOP\nPOP\n";		 // Calcule la norme de la deuxième expression arithmétique
        n2 += "PUSHF 0.0\nPUSHF 0.0\n" + $c2.code + "CALL im\nPOP\nPOP\nPOP\nPOP\nPUSHF 2.0\nCALL pow\nPOP\nPOP\nPOP\nPOP\nFADD\n";
        n2 += "CALL sqrt\nPOP\nPOP\n";
        $code = n1 + n2 + "FEQUAL\n";																										 			 // Compare les deux normes
	}

	| c1=arithmetic '<>' c2=arithmetic {																					 // Cas d'une inégalité entre deux expressions arithmétiques
    	$code = "PUSHF 0.0\n" + $c1.code + "CALL reel\nPOP\nPOP\nPOP\nPOP\nPUSHF 0.0\n" + $c2.code + "CALL reel\nPOP\nPOP\nPOP\nPOP\nFEQUAL\n";
        $code += "PUSHF 0.0\n" + $c1.code + "CALL im\nPOP\nPOP\nPOP\nPOP\nPUSHF 0.0\n" + $c2.code + "CALL im\nPOP\nPOP\nPOP\nPOP\nFEQUAL\n";
        $code += "ADD\nPUSHI 0\nEQUAL\n";
	}
// Cas d'une inégalité entre les normes de deux expressions arithmétiques
	| '|' c1=arithmetic '|' '<>' '|' c2=arithmetic '|' {
        String n1 = "PUSHF 0.0\nPUSHF 0.0\nPUSHF 0.0\n" + $c1.code + "CALL reel\nPOP\nPOP\nPOP\nPOP\nPUSHF 2.0\nCALL pow\nPOP\nPOP\nPOP\nPOP\n";
        n1 += "PUSHF 0.0\nPUSHF 0.0\n" + $c1.code + "CALL im\nPOP\nPOP\nPOP\nPOP\nPUSHF 2.0\nCALL pow\nPOP\nPOP\nPOP\nPOP\nFADD\n";
        n1 += "CALL sqrt\nPOP\nPOP\n";
        String n2 = "PUSHF 0.0\nPUSHF 0.0\nPUSHF 0.0\n" + $c2.code + "CALL reel\nPOP\nPOP\nPOP\nPOP\nPUSHF 2.0\nCALL pow\nPOP\nPOP\nPOP\nPOP\n";
        n2 += "PUSHF 0.0\nPUSHF 0.0\n" + $c2.code + "CALL im\nPOP\nPOP\nPOP\nPOP\nPUSHF 2.0\nCALL pow\nPOP\nPOP\nPOP\nPOP\nFADD\n";
        n2 += "CALL sqrt\nPOP\nPOP\n";
        $code = n1 + n2 + "FNEQ\n";
	}
 //  Cas d'une comparaison de normes (inférieur)
	| '|' c1=arithmetic '|' '<' '|' c2=arithmetic '|' {
        String n1 = "PUSHF 0.0\nPUSHF 0.0\nPUSHF 0.0\n" + $c1.code + "CALL reel\nPOP\nPOP\nPOP\nPOP\nPUSHF 2.0\nCALL pow\nPOP\nPOP\nPOP\nPOP\n";
        n1 += "PUSHF 0.0\nPUSHF 0.0\n" + $c1.code + "CALL im\nPOP\nPOP\nPOP\nPOP\nPUSHF 2.0\nCALL pow\nPOP\nPOP\nPOP\nPOP\nFADD\n";
        n1 += "CALL sqrt\nPOP\nPOP\n";
        String n2 = "PUSHF 0.0\nPUSHF 0.0\nPUSHF 0.0\n" + $c2.code + "CALL reel\nPOP\nPOP\nPOP\nPOP\nPUSHF 2.0\nCALL pow\nPOP\nPOP\nPOP\nPOP\n";
        n2 += "PUSHF 0.0\nPUSHF 0.0\n" + $c2.code + "CALL im\nPOP\nPOP\nPOP\nPOP\nPUSHF 2.0\nCALL pow\nPOP\nPOP\nPOP\nPOP\nFADD\n";
        n2 += "CALL sqrt\nPOP\nPOP\n";
        $code = n1 + n2 + "FINF\n";																						// Compare les deux normes
    }
 // Cas d'une comparaison de normes (supérieur)
	| '|' c1=arithmetic '|' '>' '|' c2=arithmetic '|' {
    	String n1 = "PUSHF 0.0\nPUSHF 0.0\nPUSHF 0.0\n" + $c1.code + "CALL reel\nPOP\nPOP\nPOP\nPOP\nPUSHF 2.0\nCALL pow\nPOP\nPOP\nPOP\nPOP\n";
        n1 += "PUSHF 0.0\nPUSHF 0.0\n" + $c1.code + "CALL im\nPOP\nPOP\nPOP\nPOP\nPUSHF 2.0\nCALL pow\nPOP\nPOP\nPOP\nPOP\nFADD\n";
        n1 += "CALL sqrt\nPOP\nPOP\n";
        String n2 = "PUSHF 0.0\nPUSHF 0.0\nPUSHF 0.0\n" + $c2.code + "CALL reel\nPOP\nPOP\nPOP\nPOP\nPUSHF 2.0\nCALL pow\nPOP\nPOP\nPOP\nPOP\n";
        n2 += "PUSHF 0.0\nPUSHF 0.0\n" + $c2.code + "CALL im\nPOP\nPOP\nPOP\nPOP\nPUSHF 2.0\nCALL pow\nPOP\nPOP\nPOP\nPOP\nFADD\n";
        n2 += "CALL sqrt\nPOP\nPOP\n";
        $code = n1 + n2 + "FSUP\n";
	}
// Cas d'une comparaison de normes (inférieur ou égal)
	| '|' c1=arithmetic '|' '<=' '|' c2=arithmetic '|' {
    	String n1 = "PUSHF 0.0\nPUSHF 0.0\nPUSHF 0.0\n" + $c1.code + "CALL reel\nPOP\nPOP\nPOP\nPOP\nPUSHF 2.0\nCALL pow\nPOP\nPOP\nPOP\nPOP\n";
        n1 += "PUSHF 0.0\nPUSHF 0.0\n" + $c1.code + "CALL im\nPOP\nPOP\nPOP\nPOP\nPUSHF 2.0\nCALL pow\nPOP\nPOP\nPOP\nPOP\nFADD\n";
        n1 += "CALL sqrt\nPOP\nPOP\n";
        String n2 = "PUSHF 0.0\nPUSHF 0.0\nPUSHF 0.0\n" + $c2.code + "CALL reel\nPOP\nPOP\nPOP\nPOP\nPUSHF 2.0\nCALL pow\nPOP\nPOP\nPOP\nPOP\n";
        n2 += "PUSHF 0.0\nPUSHF 0.0\n" + $c2.code + "CALL im\nPOP\nPOP\nPOP\nPOP\nPUSHF 2.0\nCALL pow\nPOP\nPOP\nPOP\nPOP\nFADD\n";
        n2 += "CALL sqrt\nPOP\nPOP\n";
        $code = n1 + n2 + "FINFEQ\n";
	}
// Cas d'une comparaison de normes (supérieur ou égal)
	| '|' c1=arithmetic '|' '>=' '|' c2=arithmetic '|' {
    	String n1 = "PUSHF 0.0\nPUSHF 0.0\nPUSHF 0.0\n" + $c1.code + "CALL reel\nPOP\nPOP\nPOP\nPOP\nPUSHF 2.0\nCALL pow\nPOP\nPOP\nPOP\nPOP\n";
        n1 += "PUSHF 0.0\nPUSHF 0.0\n" + $c1.code + "CALL im\nPOP\nPOP\nPOP\nPOP\nPUSHF 2.0\nCALL pow\nPOP\nPOP\nPOP\nPOP\nFADD\n";
        n1 += "CALL sqrt\nPOP\nPOP\n";
        String n2 = "PUSHF 0.0\nPUSHF 0.0\nPUSHF 0.0\n" + $c2.code + "CALL reel\nPOP\nPOP\nPOP\nPOP\nPUSHF 2.0\nCALL pow\nPOP\nPOP\nPOP\nPOP\n";
        n2 += "PUSHF 0.0\nPUSHF 0.0\n" + $c2.code + "CALL im\nPOP\nPOP\nPOP\nPOP\nPUSHF 2.0\nCALL pow\nPOP\nPOP\nPOP\nPOP\nFADD\n";
        n2 += "CALL sqrt\nPOP\nPOP\n";
        $code = n1 + n2 + "FSUPEQ\n";
	}
// Cas de l'opérateur logique "non"
	| 'non' b=bool {
    	$code = "PUSHI 1\n" + $b.code + "NEQ\n";
	}
 // Cas de l'opérateur logique "et"
	| b1=bool 'et' b2=bool {
	    label = label + 2;
        $code = $b1.code + "PUSHI 0\nNEQ\nJUMPF lab" + (label - 2) + "\n" +  // Pour l'evaluation paresseuse
    	        $b2.code + "JUMP lab" + (label - 1) + "\n" + // Code si b1 est vrai (-> b2)
    	        "LABEL lab" + (label - 2) + "\nPUSHI 0\n" + // code si b1 est faux (-> faux)
    	        "LABEL lab" + (label - 1) + "\n"; // Pour pouvoir reprendre la suite du code
	}
// Cas de l'opérateur logique "ou"
	| b1=bool 'ou' b2=bool {
	    label = label + 2;
    	$code = $b1.code + "PUSHI 0\nEQUAL\nJUMPF lab" + (label - 2) + "\n" +  // Pour l'evaluation paresseuse
    	        $b2.code + "JUMP lab" + (label - 1) + "\n" + // Code si b1 est faux (-> b2)
    	        "LABEL lab" + (label - 2) + "\nPUSHI 1\n" + // code si b1 est vrai (-> vrai)
    	        "LABEL lab" + (label - 1) + "\n"; // Pour pouvoir reprendre la suite du code
	}
 // Cas de la valeur booléenne "true"
	| 'true' {
    	$code = "PUSHI 1\n";		// Retourne vrai 
	}
// Cas de la valeur booléenne "false"
	| 'false' {
    	$code = "PUSHI 0\n";		// Retourne faux
	}
	;


// Règles du lexer
END : ';' (NEWLINE)* ;                      // Comment se termine une instruction
NEWLINE : '\r'? '\n';                       // Definis un retour a la ligne
TYPE : 'Complexe' | 'Booleen';              // Definie les differents Type accepter par notre langage
IDENTIFIANT : ([a-zA-Z] [a-zA-Z0-9_]* [a-zA-Z_]+ [a-zA-Z0-9_]*) | ([a-hj-zA-Z] [a-zA-Z0-9_]*);       // Definie la structure des nom de variable accepter par notre langage
ENTIER : ('0'..'9')+;                       // Definie la representation des entiers
WS : (' ' | '\t')+ -> skip;                 // Supprime tout les espace et tabulation en trop dans notre programme
UNMATCH : . -> skip;                        // Ignore tout ce qui n'est pas accepter


//  *********************** bug constatés  ***********************
// Aucune erreur trouver, malgres toute une batterie de teste effectuer pas nos soins!

// Comme nous avons utiliser le moins possible java et le plus possible MVaP, nos fonctions cos, sin et sqrt ne sont pas tres fiable.
// Nous utilisons les suites de Taylor avec les 10 premier termes! Pour augmenter la precision il faut augmenter le nombre de termes. Cela reduira toutefois la rapidité du programme!
// On estime que cos et sin sont precise pour des nombres < 6 (moins de 0.01 de difference avec le bon resultat) sur 10 termes
// et pour des nombres < 27 sur 40 termes
// Si vous voulez augmenter le nombre de terme, modifier la valeur de "precision" dans le '@parser::members'

// Pour utiliser les fonctions cos et sin de la bibliotheque math de java, nous avions utiliser un 2eme attribut flottant value pour les flottants et 2 flottants partReel et partIm pour les complexes contre 1 entier value pour les booleens!
// Toutefois, nous n'utilisions quasiment plus les fonctionnalité de MVaP et avons preferer realiser un maximum avec la machine virtuelle!


// ***********************  Fonctionalités non-implémentées  ***********************
// Tout a etait implementées, nous avons toutefois changer la signature de la fonction lire qui prend desormais un argument (le nom de variable) dans laquelle enregistrer la donnee


// ***********************  autres commantaires  ***********************
// 1. Performance :
//    - Le code généré est legerement optimisé pour une exécution rapide et efficace pour du MVaP mais pourrais l'etre encore en ne generant les fonctions mvap seulement quand elle sont utiliser (utilisation d'un equivalent au patron singleton).

// 2. Tests :
//    - Une couverture de tests exhaustive a été réalisée par nos soins pour garantir la fiabilité du langage.

// 4. Langage cible :
//    - Tout est gerer par une machine MVaP. Seule la gestion des numero de Label et les adresses memoire dans la pile son gerer par java!