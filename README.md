# CRM_PahanaEdu
Book Shop Web System that cashier can generate customer's bills from the system and admin can manage the users,item,customers and view generated bill and the system.

## 1. Features
### 1.1 Admin Features
- Admin Login(Username:Admin / Password:Admin12345)
- Register and manage Users(Admin or Cashier)
- Add and manage Customers(Prevent duplicate Account Number for different customers)
- Add and manage Items(Prevent duplicate Item Code for different items)
- View generated bills
- Help Section for new Admin
- HttpSession and usertype validation

### 1.2 Cashier Features
- Cashier Login
- Generate Bill with customer accounts and bill items
- View generated Bill
- Help section for new cashier
- HttpSession and usertype validation

## 2. Installation
To run this locally you need below requirments

### 2.1 Software Requirements
- Download Apache Tomcat and install it on your computer
- Download Xampp for database connection and install it to your computer
- Download Intelijj Idea Ultimate as the IDE for run this program.

### 2.2 Run the project
- Download this project and open in IDE as mern project.
- Then click the "Current File" on the top of the navbar in the IDE and select Edit Configurations
- Press the "+" icon and select the Tomcat Local on the options
- Add suitable name on the name filed and change the port to 8086 or any other number.
- After that don't click ok or apply buttons, then go to the "Deployment" tab and there press "+" mark and select "Artifact" then select "Exploade" option(like as view: /billsystem_war_exploded)
- Then press Apply and ok.
- Open the Xampp and run the database and create a database table named "bill_system" and insert the database tables that locate on resources folder on project directory.
- After that go to the IDE and Run the project by clicking the TomCat selection.
- Use the mailtrap credintials for Utils->EmailUtil java class,Then view bill preview via email.

### 2.3 Dependencies
If any case you get a error on Dependencies on this project then please copy below Dependencies to your project pom.xml file and reload the maven

```xml
<dependencies>
    <dependency>
        <groupId>javax.servlet</groupId>
        <artifactId>javax.servlet-api</artifactId>
        <version>4.0.1</version>
        <scope>provided</scope>
    </dependency>
    
    <dependency>
        <groupId>mysql</groupId>
        <artifactId>mysql-connector-java</artifactId>
        <version>8.0.33</version> 
    </dependency>
    
    <dependency>
        <groupId>com.sun.mail</groupId>
        <artifactId>jakarta.mail</artifactId>
        <version>2.0.1</version>
    </dependency>
    
    <dependency>
        <groupId>org.junit.jupiter</groupId>
        <artifactId>junit-jupiter</artifactId>
        <version>5.9.3</version>
        <scope>test</scope>
    </dependency>
    
    <dependency>
        <groupId>org.mockito</groupId>
        <artifactId>mockito-core</artifactId>
        <version>5.2.0</version>
        <scope>test</scope>
    </dependency>
</dependencies>
```
