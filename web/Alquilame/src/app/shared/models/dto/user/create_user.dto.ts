export class CreateUserDto {
  username:       string;
  email:          string;
  address:        string;
  phoneNumber:    string;
  fullName:       string;
  password:       string;
  verifyPassword: string;

  constructor(username: string, email: string, address: string, phoneNumber: string, fullName: string, password: string, verifyPassword: string) {
    this.username = username;
    this.email = email;
    this.address = address;
    this.phoneNumber = phoneNumber;
    this.fullName = fullName;
    this.password = password;
    this.verifyPassword = verifyPassword;
  }
}
