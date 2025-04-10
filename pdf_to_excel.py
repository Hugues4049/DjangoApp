import pdfplumber
import pandas as pd

def pdf_to_excel_with_pdfplumber(pdf_path, excel_path):
    try:
        # Ouvrir le fichier PDF
        with pdfplumber.open(pdf_path) as pdf:
            all_tables = []
            for page in pdf.pages:
                # Extraire les tableaux
                tables = page.extract_tables()
                if tables:
                    for table in tables:
                        df = pd.DataFrame(table)
                        all_tables.append(df)
            
            # Vérifier si des tableaux ont été trouvés
            if not all_tables:
                raise ValueError("Aucune table n'a été trouvée dans le fichier PDF.")
            
            # Enregistrer toutes les tables dans un fichier Excel
            with pd.ExcelWriter(excel_path, engine='openpyxl') as writer:
                for i, table_df in enumerate(all_tables):
                    sheet_name = f"Table_{i+1}"
                    table_df.to_excel(writer, sheet_name=sheet_name, index=False)
        
        print(f"Conversion réussie ! Fichier Excel sauvegardé sous : {excel_path}")
    
    except Exception as e:
        print(f"Erreur lors de la conversion : {e}")

# Exemple d'utilisation
if __name__ == "__main__":
    # Chemin du fichier PDF à convertir
    pdf_path = "/home/roland/Téléchargements/Fiche candidatures - Feuille 1.pdf"
    # Chemin du fichier Excel de sortie
    excel_path = "/home/roland/Téléchargements/Fiche candidatures - Feuille 1.xlsx"
    
    # Appeler la fonction pour convertir
    pdf_to_excel_with_pdfplumber(pdf_path, excel_path)
    
