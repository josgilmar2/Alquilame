export class EditUserDto {
  fullName:    string;
  address:     string;
  phoneNumber: string;

  constructor(fullName: string, address: string, phoneNumber: string) {
    this.fullName = fullName;
    this.address = address;
    this.phoneNumber = phoneNumber;
  }
}
