//
//  HomeViewModel.swift
//  CatChat
//
//  Created by Rahardyan Bisma Setya Putra on 25/01/20.
//  Copyright © 2020 Amsibsam. All rights reserved.
//

import UIKit
import QiscusCore

class HomeViewModel {
    // MARK: - Private properties -
    private let navigator: HomeNavigator
    private let interactor: HomeInteractor
    
    // MARK: - Public properties -
    var onLoadRoomError: ((String) -> Void)? = nil
    var onNeedReloadRooms: (() -> Void)? = nil
    var onNeedReconfigNode: (() -> Void)? = nil
    var onGotNewRoom: ((IndexPath) -> Void)? = nil
    var onNeedReconfigTabBar: ((Bool) -> Void)? = nil
    var chatRooms: [RoomModel] = []
    
    init(navigator: HomeNavigator, interactor: HomeInteractor) {
        self.navigator = navigator
        self.interactor = interactor
    }
    
    // MARK: - Public Function -
    func listenRoomEvent(isNeedToListen: Bool) {
        if isNeedToListen {
            self.interactor.listenRoomChanges(onGotNewRoom: { [weak self] (room) in
                if let _ = self?.chatRooms.filter({ (filterRoom) -> Bool in
                    return filterRoom.id == room.id
                }).first {
                    return
                }
                
                self?.chatRooms.insert(room, at: 0)
                self?.onGotNewRoom?(IndexPath(row: 0, section: 0))
            }, onNeedReloadRooms: { [weak self] in
                self?.onNeedReloadRooms?()
            })
            
            return
        }
        
        self.interactor.unlistenRoomChanges()
    }
    
    func createChat() {
        navigator.openCreateRoom()
    }
    
    func startChat(with partnerUserid: String) {
        navigator.openChatRoom(with: partnerUserid)
    }
    
    func startChat(with indexPath: IndexPath) {
        guard let partnerId = chatRooms[indexPath.row].partner?.id else {
            return
        }
        
        navigator.openChatRoom(with: partnerId)
    }
    
    func isLocalRoomEmpty() -> Bool {
        let localRoom = self.interactor.fetchRoomsFromLocal()
        return localRoom.isEmpty
    }
    
    func loadRooms() {
        self.fetchRoomFromLocal(isAfterFetchFromServer: false)
        
        self.fetchRoomFromServer()
    }
    
    func createRoomCellViewModel(forIndexPath indexPath: IndexPath) -> HomeChatRoomCellViewModel {
        return HomeChatRoomCellViewModel(navigator: self.navigator, chatRoom: self.chatRooms[indexPath.row])
    }
    
    // MARK: - Private Function -
    
    private func fetchRoomFromLocal(isAfterFetchFromServer: Bool) {
        self.chatRooms = self.interactor.fetchRoomsFromLocal()
        
        if self.chatRooms.isEmpty && !isAfterFetchFromServer {
            self.navigator.showFetchingLoading()
            self.onNeedReconfigTabBar?(false)
        } else {
            self.navigator.dismissFetchingLoading()
            self.onNeedReloadRooms?()
            self.onNeedReconfigNode?()
            self.onNeedReconfigTabBar?(!self.chatRooms.isEmpty)
        }
    }
    
    private func fetchRoomFromServer() {
        interactor.fetchRoomsFromServer(onFetchSuccess: { [weak self] in
            self?.fetchRoomFromLocal(isAfterFetchFromServer: true)
        }) { (error) in
            
        }
    }
}
