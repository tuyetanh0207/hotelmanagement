﻿using BUS_HotelManagement;
using DTO_HotelManagement;
using DTO_HoTelManagement;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Security.Policy;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using static System.Windows.Forms.VisualStyles.VisualStyleElement;

namespace GUI_HotelManagement
{
    public partial class ServiceForm : Form
    {
        public ServiceForm()
        {
            InitializeComponent();
            displayService();

        }

        public void displayService()
        {
            string ServiceType = Service_ComboBox.Items[0].ToString();
            Service_ComboBox.Text = ServiceType;
            Service_DataGrid.DataSource = HotelService_BUS.LoadDataServiceHotel();
            Floor_ComboBox.DataSource = setFloorBox();
            UDService_ComboBox.DataSource = HotelService_BUS.getServiceName();
        }

        public List<string> setFloorBox()
        {
            List<string> floors = new List<string>();

            List<string> roomNumbers = Room_BUS.getListRoom();
            foreach (string roomNumber in roomNumbers)
            {
                string floor = roomNumber.Substring(6, 1);
                if (!floors.Contains(floor))
                {
                    floors.Add(floor);
                }
            }
            return floors;
        }

        private void Service_ComboBox_SelectedIndexChanged(object sender, EventArgs e)
        {
            string selectedValue = Service_ComboBox.SelectedItem.ToString();
            if (selectedValue == "  Dịch vụ khách sạn")
            {
                Service_ComboBox.Text = selectedValue;
                Service_DataGrid.DataSource = HotelService_BUS.LoadDataServiceHotel();
                Infor_Label.Text = "Chương trình khuyến mãi kèm theo";
                //UD_Panel.Hide();
                //UD_Panel.Show();
            }
        }

        private void Floor_ComboBox_SelectedIndexChanged(object sender, EventArgs e)
        {
            string selectedValue = Floor_ComboBox.SelectedItem.ToString();

            List<string> updatedValues = Room_BUS.getListFRoom(selectedValue);

            // Cập nhật danh sách giá trị ComboBox 2 và chọn giá trị đầu tiên
            Room_ComboBox.DataSource = updatedValues;
            Room_ComboBox.SelectedIndex = 0;
        }

        private void button5_Click(object sender, EventArgs e)
        {
            string roomName = Room_ComboBox.Text;
            Room_DTO room = new Room_DTO(roomName);
            if (Room_BUS.getRoomService(room).Rows.Count <= 0)
            {
                MessageBox.Show("Phòng không cung cấp dịch vụ!");
                ServiceForRoom_DataGrid.DataSource = null;
                return;
            }
            ServiceForRoom_DataGrid.DataSource = Room_BUS.getRoomService(room);
        }

        public bool isChoose = true;
        private void Service_DataGrid_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {
            isChoose = true;
            if (e.ColumnIndex == Service_DataGrid.Columns["ID_Service"].Index && e.RowIndex >= 0 && isChoose)
            {
                string selectedID = Service_DataGrid.Rows[e.RowIndex].Cells["ID_Service"].Value.ToString();
                ShowDiscountOfService(selectedID);
            }
            else return;
        }
        public void ShowDiscountOfService(string selectedID)
        {
            HotelService_DTO IdService = new HotelService_DTO(selectedID);
            if (HotelService_BUS.LoadDataDiscountService(IdService).Rows.Count <= 0)
            {
                MessageBox.Show("Dịch vụ không có chương trình khuyến mãi");
                Discount_DataGid.DataSource = null;
                return;
            }
            Discount_DataGid.DataSource = HotelService_BUS.LoadDataDiscountService(IdService);
        }

        private void ServiceForRoom_DataGrid_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {
            isChoose = false;
            if (e.ColumnIndex == ServiceForRoom_DataGrid.Columns["ID_Service"].Index && e.RowIndex >= 0 && !isChoose)
            {
                string selectedID = ServiceForRoom_DataGrid.Rows[e.RowIndex].Cells["ID_Service"].Value.ToString();
                ShowDiscountOfService(selectedID);
            }
        }

        private void button4_Click(object sender, EventArgs e)
        {
            displayService();
            ServiceForRoom_DataGrid.DataSource = null;
            Discount_DataGid.DataSource = null;
        }

        private void button1_Click(object sender, EventArgs e)
        {
            addServiceForm addService = new addServiceForm();
            addService.ShowDialog();
        }

        private void button3_Click(object sender, EventArgs e)
        {
            string ServiceName = UDService_ComboBox.Text;
            MessageBox.Show(ServiceName);
            HotelService_DTO nameService = new HotelService_DTO(null, ServiceName);
            bool flag = HotelService_BUS.disableService(nameService);
            MessageBox.Show(flag.ToString());

            if (flag)
            {
                MessageBox.Show("Vô hiệu thành công!");
                Service_DataGrid.DataSource = HotelService_BUS.LoadDataServiceHotel();
                Discount_DataGid.DataSource = null;

                // Xóa giá trị đã vô hiệu khỏi DataGridView ServiceForRoom_DataGrid
                foreach (DataGridViewRow row in ServiceForRoom_DataGrid.Rows)
                {
                    if (row.Cells["NAME"].Value.ToString() == ServiceName)
                    {
                        ServiceForRoom_DataGrid.Rows.Remove(row);
                        break;
                    }
                }
                return;
            }
            else
            {
                MessageBox.Show("Vô hiệu thất bại!");
                return;
            }

        }

        private void button2_Click(object sender, EventArgs e)
        {
            string serviceName = UDService_ComboBox.Text;
            HotelService_DTO nameService = new HotelService_DTO(null, serviceName);
            addServiceForm updateService = new addServiceForm(nameService);
            updateService.ShowDialog();
        }


    }
}
