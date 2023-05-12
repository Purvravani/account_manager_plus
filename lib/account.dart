class Account
{
  // {id: 1, name: harmit vaghani, acid: 1,
  // date: 11/1/2023, amount: 1000, type: debit, reason: nasta}
  int? id,acid,amount;
  String? name,type,reason;

  Account(
      {this.id,
        this.acid,
        this.amount,
        this.name,
        this.type,
        this.reason}); //alt+insert


  static Account frommap(Map m)
  {
    return Account(id: m['id'], acid: m['acid'],amount: m['amount'],name: m['name'],type: m['type'],reason: m['reason']);
  }

  @override
  String toString() {
    return 'Account{id: $id, acid: $acid, amount: $amount, name: $name, type: $type, reason: $reason}';
  }
}
class Transaction
{
  int id,acid,amount;
  String date,reason,type;

  Transaction(
      this.id, this.acid, this.amount, this.date, this.reason, this.type);

  @override
  String toString() {
    return 'Transaction{id: $id, acid: $acid, amount: $amount, date: $date, reason: $reason, type: $type}';
  }
  static Transaction fromMap(Map m)
  {
    return Transaction(m['id'], m['acid'], m['amount'], m['date'], m['reason'], m['type']);
  }

}