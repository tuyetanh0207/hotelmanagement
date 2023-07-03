﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DAO_HotelManagement;
using DTO_HotelManagement;
using System.Data;

namespace BUS_HotelManagement
{
    public class BookingForm_BUS
    {
        //BookingForm_DAO daoBookingForm = new BookingForm_DAO();
        public bool checkExistedCTM(string idCard)
        {
            return BookingForm_DAO.Instance.checkExistedCTM(idCard);
        }
        public DataTable getInforExistedCTM(string idCard)
        {
            return BookingForm_DAO.Instance.getInforExistedCTM(idCard);
        }
        public static DataTable LoadData(BookingForm_DTO BookingId)
        {
            return BookingForm_DAO.Instance.LoadData(BookingId);
        }
        public static DataTable getListRoom(BookingForm_DTO BookingId)
        {
            return BookingForm_DAO.Instance.getListRoom(BookingId);
        }
        public static string getGuestName(BookingForm_DTO BookingId)
        {
            return BookingForm_DAO.Instance.getGuestName(BookingId);
        }
        public static string getNumberofrooms(BookingForm_DTO BookingId)
        {
            return BookingForm_DAO.Instance.getNumberofrooms(BookingId);
        }
        public static string getNoIdentity(BookingForm_DTO BookingId)
        {
            return BookingForm_DAO.Instance.getNoIdentity(BookingId);
        }
        public static string getSPRequires(BookingForm_DTO BookingId)
        {
            return BookingForm_DAO.Instance.getSPRequires(BookingId);
        }

        public static string getPrice(BookingForm_DTO BookingId)
        {
            return BookingForm_DAO.Instance.getPrice(BookingId);
        }
        public static string getPaymenMethods(BookingForm_DTO BookingId)
        {
            return BookingForm_DAO.Instance.getPaymenMethods(BookingId);
        }
        public static bool check_Booking(BookingForm_DTO BookingId)
        {
            return BookingForm_DAO.Instance.check_Booking(BookingId);
        }
        public static DateTime getIn_Date(BookingForm_DTO BookingId)
        {
            return BookingForm_DAO.Instance.getDateIn(BookingId);
        }
        public static DateTime getOut_Date(BookingForm_DTO BookingId)
        {
            return BookingForm_DAO.Instance.getDateOut(BookingId);
        }
        public static bool Update_BookingForm(BookingForm_DTO BookingId)
        {
            return BookingForm_DAO.Instance.Update_BookingForm(BookingId);
        }
        public static List<string> getListRoomOfBooking(BookingForm_DTO BookingId)
        {
            return BookingForm_DAO.Instance.getListRoomOfBooking(BookingId);
        }
        public static bool insertBookingForm(BookingForm_DTO inforBooking)
        {
            return BookingForm_DAO.Instance.insertBookingForm(inforBooking);
        }
    }
}
