public class FactoryMethodPatternExample {

    // Step 2: Define Document Interface
    interface Document {
        void open();
    }

    // Step 3: Create Concrete Document Classes
    static class WordDocument implements Document {
        @Override
        public void open() {
            System.out.println("Opening a Word document.");
        }
    }

    static class PdfDocument implements Document {
        @Override
        public void open() {
            System.out.println("Opening a PDF document.");
        }
    }

    static class ExcelDocument implements Document {
        @Override
        public void open() {
            System.out.println("Opening an Excel document.");
        }
    }

    // Step 4: Implement the Factory Method
    abstract static class DocumentFactory {
        // Factory method
        public abstract Document createDocument();
    }

    // Concrete factories
    static class WordDocumentFactory extends DocumentFactory {
        @Override
        public Document createDocument() {
            return new WordDocument();
        }
    }

    static class PdfDocumentFactory extends DocumentFactory {
        @Override
        public Document createDocument() {
            return new PdfDocument();
        }
    }

    static class ExcelDocumentFactory extends DocumentFactory {
        @Override
        public Document createDocument() {
            return new ExcelDocument();
        }
    }

    // Step 5: Test the Factory Method Implementation
    public static class FactoryTest {
        public static void main(String[] args) {
            // Create a Word document using the factory
            DocumentFactory wordFactory = new WordDocumentFactory();
            Document wordDocument = wordFactory.createDocument();
            wordDocument.open();

            // Create a PDF document using the factory
            DocumentFactory pdfFactory = new PdfDocumentFactory();
            Document pdfDocument = pdfFactory.createDocument();
            pdfDocument.open();

            // Create an Excel document using the factory
            DocumentFactory excelFactory = new ExcelDocumentFactory();
            Document excelDocument = excelFactory.createDocument();
            excelDocument.open();
        }
    }
}
