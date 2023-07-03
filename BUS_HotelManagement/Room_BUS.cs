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
    public class Room_BUS
    {

        public DataTable getRoom()
        {
            return Room_DAO.Instance.getRoom();
        }

        public static List<string> getListRoom()
        {
            return Room_DAO.Instance.getListRoom();
        }
        public static List<string> getListRoom(string filterStatus, string filterType)
        {
            return Room_DAO.Instance.getListRoom(filterStatus, filterType);
        }
        public static List<string> getListFRoom(string floor)
        {
            return Room_DAO.Instance.getListFRoom(floor);
        }
        public static DataTable getRoomService(Room_DTO RoomName)
        {
            return Room_DAO.Instance.getRoomService(RoomName);
        }
        public static string getRoomStatus(Room_DTO RoomName)
        {
            return Room_DAO.Instance.getRoomStatus(RoomName);
        }
        public static List<string> getListRoom_Status(string filterStatus, string filterType)
        {
            return Room_DAO.Instance.getListRoomFilter_Status(filterStatus, filterType);
        }
        public static List<string> getListRoom_Type(string filterStatus, string filterType)
        {
            return Room_DAO.Instance.getListRoomFilter_Type(filterStatus, filterType);
        }
        public static string getRoomInformation(Room_DTO RoomName)
        {
            return Room_DAO.Instance.getRoomInformation(RoomName);
        }
        public static string getCustomerRoomInformation(Room_DTO RoomName)
        {
            return Room_DAO.Instance.getCustomerRoomInformation(RoomName);
        }
        public static string getRoomPrice(Room_DTO RoomName)
        {
            return Room_DAO.Instance.getRoomPrice(RoomName);
        }
        public static DataTable getRoomItems(Room_DTO RoomName)
        {
            return Room_DAO.Instance.getRoomItems(RoomName);
        }
        public static bool updatePriceRoom(Room_DTO RoomName)
        {
            return Room_DAO.Instance.updatePriceRoom(RoomName);
        }

        public static string getRoomId(Room_DTO RoomName)
        {
            return Room_DAO.Instance.getRoomId(RoomName);
        }
        public static List<string> getListItems(Room_DTO RoomInfo)
        {
            return Room_DAO.Instance.getListItems(RoomInfo);
        }
    }
}
