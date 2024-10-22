public class Booking {
    private int bookingID;
    private int customerID;
    private String bookingHour;
    public Booking(int bookingID, int customerID, String bookingHour) {
        this.bookingID = bookingID;
        this.customerID = customerID;
        this.bookingHour = bookingHour;
    }
    public int getBookingID() {
        return bookingID;
    }
    public String getBookingHour() {
        return bookingHour;
    }
    public int getCustomerID() {
        return customerID;
    }
}
